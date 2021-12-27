//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Dallin Jared on 12/26/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [Statistic] = []
    
    @Published var allCoins = [Coin]()
    @Published var portfolioCoins = [Coin]()
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self](returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables )
        
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coins, portfolioEntities) -> [Coin] in
                coins
                    .compactMap { (coin) -> Coin? in
                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||       coin.symbol.lowercased().contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapGlobalMarketData(marketData: MarketData?) -> [Statistic] {
            var stats: [Statistic] = []
            
            guard let data = marketData else { return stats }
            
            let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            let volume = Statistic(title: "24h Volume", value: data.volume)
            let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
            let portfolio = Statistic(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
            
            stats.append(contentsOf: [
                marketCap,
                volume,
                btcDominance,
                portfolio
            ])
            return stats
    }
}

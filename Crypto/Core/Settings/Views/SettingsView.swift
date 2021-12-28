//
//  SettingsView.swift
//  Crypto
//
//  Created by Dallin Jared on 12/27/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var isPresented: Bool
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://github.com/dallinjared")!
    
    var body: some View {
        NavigationView {
            List{
                swiftfulThinkingSection
                coinGeckoSection
                developerSection
                applicationSection
            }
            .accentColor(.blue)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        XMarkLabel()
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}

extension SettingsView {
    private var swiftfulThinkingSection: some View {
        Section(header: Text("Section")) {
            VStack(alignment: .center) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine and CoreData")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on YouTube", destination: youtubeURL)
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .center) {
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko", destination: coingeckoURL)
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .center) {
                HStack {
                    Image("profile")
                        .resizable()
                        .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    VStack (alignment: .leading) {
                        Text("Dallin Jared")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.secondaryText)
                        Text("iOS/Full-Stack Developer")
                            .font(.caption)
                    }
                }
                Text("This app was developed by Dallin Jared through an online course. It is written in Swift/SwiftUI. The project benefits from multi-threading, publishers/subscribers and data persistance through CoreData.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit my GitHub", destination: personalURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
}

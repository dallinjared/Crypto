//
//  CryptoApp.swift
//  Crypto
//
//  Created by Dallin Jared on 12/25/21.
//

import SwiftUI

@main
struct CryptoApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}

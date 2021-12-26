//
//  ContentView.swift
//  Crypto
//
//  Created by Dallin Jared on 12/25/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                Text("Secondary Text Color")

                Text("Accent Color")

                Text("Accent Color")

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

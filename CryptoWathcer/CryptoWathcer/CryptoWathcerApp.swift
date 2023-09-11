//
//  CryptoWathcerApp.swift
//  CryptoWathcer
//
//  Created by Viktor Golovach on 10.09.2023.
//

import SwiftUI

@main
struct CryptoWathcerApp: App {
    
    
    @StateObject private var modelData = CoinViewModel(networkService: NetworkService())
    
    var body: some Scene {
        WindowGroup {
            ContentView().preferredColorScheme(.dark)
                .environmentObject(modelData)
        }
    }
}

//
//  ContentView.swift
//  CryptoWathcer
//
//  Created by Viktor Golovach on 10.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CoinList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CoinViewModel(networkService: NetworkService()))
    }
}

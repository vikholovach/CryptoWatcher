//
//  CoinList.swift
//  CryptoWathcer
//
//  Created by Viktor Golovach on 10.09.2023.
//

import SwiftUI

struct CoinList: View {
    
    @EnvironmentObject var modelData: CoinViewModel
    
    @State private var showFavoritesOnly = false
    
    var filteredCoins: [CoinData] {
        modelData.coins.filter { coin in
            !showFavoritesOnly || coin.isFavorite!
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorite coins")
                }
                
                ForEach(filteredCoins) { coin in
                    CoinRow(coin: coin)
                }
            }
            
            .onAppear{
                modelData.fetchCoins()
            }
            .navigationTitle("Coins")
        }
    }
}

struct CoinList_Previews: PreviewProvider {
    static var previews: some View {
        CoinList()
            .environmentObject(CoinViewModel(networkService: NetworkService()))
    }
}

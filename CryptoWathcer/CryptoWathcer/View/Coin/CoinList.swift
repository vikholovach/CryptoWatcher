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
    
    private let realm = RealmManager.shared
    
    private var filteredCoins: [CoinData] {
        modelData.coins.filter { coin in
            return !showFavoritesOnly || coin.isFavorite
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorite coins")
                }
                .tint(Color(#colorLiteral(red: 0.3484552801, green: 0.933657825, blue: 0.9058339596, alpha: 1)).opacity(0.7))
                .disabled(
                    showFavoritesOnly
                    ? false
                    : realm.favoriteCoins.isEmpty)
                
                ForEach(showFavoritesOnly
                        ? filteredCoins
                        : modelData.coins) { coin in
                    
                    NavigationLink(destination: {
                        //destination -> View on which we want to jump in
                        WebViewContainer(coin: coin)
                    }, label: {
                        //view which we want to show in list
                        CoinRow(coin: coin)
                    })
                }
            }
            .scrollContentBackground(.hidden)
            .background(ColorfulView())
            .onAppear {
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

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
    
    var filteredCoins: [CoinData] {
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
                .tint(Color(#colorLiteral(red: 0.3484552801, green: 0.933657825, blue: 0.9058339596, alpha: 1)))
                .disabled(
                    showFavoritesOnly
                    ? false
                    : realm.favoriteCoins.isEmpty)
                
                ForEach(showFavoritesOnly
                        ? filteredCoins
                        : modelData.coins) { coin in
                    CoinRow(coin: coin)
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

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(configuration.isOn ? Color.green : Color.red) // Change the colors as needed
                .frame(width: 50, height: 30) // Adjust the size as needed
            Toggle("", isOn: configuration.$isOn)
                .labelsHidden()
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

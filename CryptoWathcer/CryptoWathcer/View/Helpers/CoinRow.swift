//
//  CoinRow.swift
//  CryptoWathcer
//
//  Created by Viktor Golovach on 10.09.2023.
//

import SwiftUI

struct CoinRow: View {
    
    @EnvironmentObject var modelData: CoinViewModel
    
    let coin: CoinData
    
    private var coinPrice: Float {
        Float(coin.priceUsd) ?? 0
    }
    
    var coinIndex: Int {
        modelData.coins.firstIndex(where: {
            $0.id == coin.id
        })!
    }
    
    //MARK: - Computed properties
    private var coinFloatPercent: Float {
        return Float(coin.changePercent24Hr) ?? 0
    }
    
    var body: some View {
        HStack {
            CoinLogo(coin: coin)
            
            Text(coin.name)
                .font(.title2)
                .padding(.leading, 16)
            
            Spacer()
            
            VStack {
                Text("\(String(format:"%.02f", coinPrice))$")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    
                Text("24h ↑ \(String(format:"%.02f", coinFloatPercent))%")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.subheadline)
                    .foregroundColor(
                        coinFloatPercent < 0
                        ? .red
                        : .green
                    )
            }
            
            FavoriteButton(isSet: $modelData.coins[coinIndex].isFavorite, coin: self.coin)
            
        }
    }
    
    
    
}

struct CoinRow_Previews: PreviewProvider {
    
    static let coin = CoinViewModel(networkService: NetworkService())
    
    static var previews: some View {
        CoinRow(coin: coin.mockCoin)
            .environmentObject(CoinViewModel(networkService: NetworkService()))
    }
}

//
//  FavoriteButton.swift
//  CryptoWatcher
//
//  Created by Viktor Golovach on 11.09.2023.
//

import SwiftUI

struct FavoriteButton: View {
    
    private let realm = RealmManager.shared
    
    
    @Binding var isSet: Bool
    @State private var rotationAngle: Double = 0
    @EnvironmentObject var modelData: CoinViewModel
 
    let coin: CoinData
  
    
    private var coinIndex: Int? {
        modelData.coins.firstIndex(where: {
            $0.id == coin.id
        })
    }
    
    var body: some View {
        Button {
            isSet.toggle()
            guard let index = coinIndex else {
                print("index unavailable")
                return
            }
            let coin = modelData.coins[index]
            self.updateRealm(with: coin)
            if isSet {
                rotationAngle += 360
            } else {
                rotationAngle -= 360
            }

        } label: {
            Label("Toggle Favorite",
                  systemImage: isSet
                  ? "star.fill"
                  : "star")
            .labelStyle(.iconOnly)
            .foregroundColor(
                isSet
                ? .yellow
                : .gray)
        }
        .rotationEffect(.degrees(rotationAngle))
        .animation(.easeInOut(duration: 0.24))
        .scaleEffect(
            isSet
            ? 1.2
            : 1.0)
        
        
    }
    
    private func updateRealm(with coin: CoinData) {
        // to get index from realm array
        // and add/delete selected coin from realm DB
        if let index = realm.favoriteCoins.firstIndex(where: {
            $0.coindID == coin.id
        }) {
            let coinToDelete = realm.favoriteCoins[index]
            realm.delete(coinToDelete)
        } else {
            let coinToAdd = FavoriteCoin()
            coinToAdd.name = coin.name
            coinToAdd.coindID = coin.id
            self.realm.add(coinToAdd)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    
    static let dataModel = CoinViewModel(networkService: NetworkService())
    static var previews: some View {
        FavoriteButton(isSet: .constant(false), coin: dataModel.mockCoin)
            .environmentObject(dataModel)
    }
}

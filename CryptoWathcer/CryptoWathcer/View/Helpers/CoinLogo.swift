//
//  Logo.swift
//  CryptoWathcer
//
//  Created by Viktor Golovach on 10.09.2023.
//

import SwiftUI
import Kingfisher

struct CoinLogo: View {
    
    @EnvironmentObject var modelData: CoinViewModel
    
    let coin: CoinData
    
    //MARK: - Computed property
    private var imagePath: String {
        modelData.getImagePath(by: coin.symbol)
    }
    
    var body: some View {
        KFImage(URL(string: self.imagePath))
            .resizable()
            .clipShape(Circle())
            .frame(
                width: 48,
                height: 48)
            .overlay{
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(color: .purple, radius: 7)
            
    }
}

struct CoinLogo_Previews: PreviewProvider {
    
    static let coin = CoinViewModel(networkService: NetworkService())
    
    static var previews: some View {
        CoinLogo(coin: coin.mockCoin)
            .environmentObject(CoinViewModel(networkService: NetworkService()))
    }
}

//
//  WebViewContainer.swift
//  CryptoWatcher
//
//  Created by Viktor Golovach on 21.09.2023.
//

import SwiftUI

struct WebViewContainer: View {
    
    @State var coin: CoinData
    
    var body: some View {
        WebView(coin: $coin)
            .navigationBarTitle(coin.name)
            .padding(.top, 8)
            .padding(.trailing, 24)
            .padding(.leading, 24)
            .padding(.bottom, 0)
            .background(ColorfulView())
    }
    
}


struct WebViewContainer_Previews: PreviewProvider {
    
    static let coin = CoinViewModel(networkService: NetworkService())
    
    static var previews: some View {
        WebViewContainer(coin: coin.mockCoin)
    }
}

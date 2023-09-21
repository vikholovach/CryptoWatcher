//
//  WebView.swift
//  CryptoWatcher
//
//  Created by Viktor Golovach on 21.09.2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    @Binding var coin: CoinData
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.layer.cornerRadius = 8
        webView.layer.masksToBounds = true
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: coin.explorer ?? "https://blockchain.info/") {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}


struct WebView_Previews: PreviewProvider {
    
    static let coin = CoinViewModel(networkService: NetworkService())
    
    static var previews: some View {
        WebView(coin: .constant(coin.mockCoin))
    }
}

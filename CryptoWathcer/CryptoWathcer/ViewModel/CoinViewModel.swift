//
//  CoinViewModel.swift
//  CryptoWathcer
//
//  Created by Viktor Golovach on 10.09.2023.
//

import Combine
import Foundation

final class CoinViewModel: ObservableObject {
    @Published var coins: [CoinData] = [CoinData]()
    
    // to use in preview as mock data
    let mockCoin = CoinData(
        id: "bitcoin",
        symbol: "BTC",
        name: "Bitcoin",
        priceUsd: "25830.5227396003309120",
        changePercent24Hr: "-0.1570636474522199")
    
    // timer to run requests
    var requestTimer: Timer.TimerPublisher!
    
    var networkService: NetworkServiceProtocol!
    
    private var cancellables = Set<AnyCancellable>()
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.requestTimer = Timer.publish(every: 1, on: .main, in: .default)
    }
    
    func getImagePath(by symbol: String) -> String {
        "https://assets.coincap.io/assets/icons/\(symbol.lowercased())@2x.png"
    }
    
    func fetchCoins() {
        requestTimer
            .autoconnect()
            .sink {[weak self] _ in
                guard let self = self else {return}
                Task {
                    let response = await self.networkService.fetchPrice()
                    DispatchQueue.main.async {
                        switch response {
                        case .success(let coins):
                            //apply data to publisher
                            self.coins = coins
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
}

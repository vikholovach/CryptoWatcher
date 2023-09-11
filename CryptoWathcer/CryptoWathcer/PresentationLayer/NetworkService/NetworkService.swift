//
//  NetworkService.swift
//  CryptoWathcer
//
//  Created by Viktor Golovach on 10.09.2023.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchPrice() async -> (Result<[CoinData], Error>)
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    //url to get bitcoin price
    private let url = "https://api.coincap.io/v2/assets"
        
    func fetchPrice() async -> (Result<[CoinData], Error>) {
        guard let url = URL(string: self.url) else {
            return .failure(NetworlErrors.badUrl)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let coin = try JSONDecoder().decode(CoinModel.self, from: data)
            return .success(coin.data)
        }
        catch {
            return .failure(error)
        }
    }
    
   
    
}

enum NetworlErrors: String, Error {
    case badUrl = "Bad url"
}

//
//  CoinModel.swift
//  CryptoWathcer
//
//  Created by Viktor Golovach on 10.09.2023.
//

import Foundation

struct CoinModel: Codable, Equatable, Hashable {
    let data: [CoinData]
}

struct CoinData: Codable, Equatable, Hashable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let priceUsd: String
    let changePercent24Hr: String
    let explorer: String?
    
    // not containt in JSON resppnse
    // so we adding coding keys 
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case priceUsd
        case changePercent24Hr
        case explorer
    }
}

//
//  FavoriteCoin.swift
//  CryptoWatcher
//
//  Created by Viktor Golovach on 11.09.2023.
//

import RealmSwift
import Foundation

class FavoriteCoin: Object {
    @Persisted var coindID: String = ""
    @Persisted var name: String = ""
    @Persisted var id: Int = 0
    override class func primaryKey() -> String? {
        return "id"
    }
}

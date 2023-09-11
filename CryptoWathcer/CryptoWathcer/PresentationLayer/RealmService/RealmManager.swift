//
//  RealmManager.swift
//  CryptoWatcher
//
//  Created by Viktor Golovach on 11.09.2023.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
    static let shared = RealmManager()
    private let realm = try! Realm()
    
    lazy var favoriteCoins : Results<FavoriteCoin> = { getData(ofType: FavoriteCoin.self) }()
    
    // to fetch data from realm
    private func getData<T: Object>(ofType: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
    
    //to add coin to realm
    func add(_ coin: FavoriteCoin) {
        coin.id = (self.realm.objects(FavoriteCoin.self).max(ofProperty: "id") as Int? ?? 0) + 1
        do {
            try realm.write {
                realm.add(coin, update: .error)
                print("added \(coin.name) to database")
            }
        } catch {
            print("Could not save \(coin.name)! \n\(String(describing: error.localizedDescription))")
        }
    }
    
    func delete(_ coin: FavoriteCoin) {
        do {
            try realm.write {
                print("deleted \(coin.name)from database")
                realm.delete(coin)
            }
        } catch {
            print("Could not delete \(coin.name)!\n\(String(describing: error.localizedDescription))")
        }
    }
    
}

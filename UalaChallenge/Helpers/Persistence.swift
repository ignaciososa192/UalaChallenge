//
//  Persistence.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import Foundation

struct FavoritesStore {
    private static let key = "favoriteCityIDs"
    static var ids: Set<Int> {
        get { Set(UserDefaults.standard.array(forKey:key) as? [Int] ?? []) }
        set { UserDefaults.standard.set(Array(newValue), forKey:key) }
    }
}

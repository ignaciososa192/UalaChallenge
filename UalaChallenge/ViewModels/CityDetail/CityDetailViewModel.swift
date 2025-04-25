//
//  CityDetailViewModel.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import Foundation
import Combine

final class CityDetailViewModel: ObservableObject {
    @Published var isFavorite: Bool
    
    let city: City
    
    init(city: City, isFavorite: Bool = false) {
        self.city = city
        self.isFavorite = isFavorite
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
    }
}

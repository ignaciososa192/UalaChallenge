//
//  CitySearcher.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import Foundation

class CitySearch {
    private let cities: [City] // ya ordenado por name.lowercased()
    private let lowercasedNames: [String] // solo nombres en lowercase
    
    init(cities: [City]) {
        self.cities = cities.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
        self.lowercasedNames = self.cities.map { $0.name.lowercased() }
    }
    
    func search(prefix: String) -> [City] {
        let p = prefix.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !p.isEmpty else { return cities }
        var lo = 0, hi = lowercasedNames.count
        while lo < hi {
            let mid = (lo + hi) / 2
            if lowercasedNames[mid] < p {
                lo = mid + 1
            } else {
                hi = mid
            }
        }

        var results: [City] = []
        for i in lo..<lowercasedNames.count {
            let name = lowercasedNames[i]
            if name.hasPrefix(p) {
                results.append(cities[i])
            } else {
                break
            }
        }
        return results
    }
}

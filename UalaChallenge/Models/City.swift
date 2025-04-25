//
//  City.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import Foundation

struct City: Identifiable, Codable {
    let _id: Int
    let name: String
    let country: String
    let coord: Coordinate

    var id: Int { _id }
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}

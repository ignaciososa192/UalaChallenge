//
//  JSONLoader.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import Foundation

struct JSONLoader {
    static func load<T: Decodable>(_ filename: String, as type: T.Type) throws -> T {
        let url = Bundle.main.url(forResource: filename, withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

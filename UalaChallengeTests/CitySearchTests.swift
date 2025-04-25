//
//  CitySearchTests.swift
//  UalaChallengeTests
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import XCTest
@testable import UalaChallenge

final class CitySearchTests: XCTestCase {
    var searcher: CitySearch!

    override func setUp() {
        super.setUp()
        let cities = [
            City(_id: 0, name: "Alabama", country: "US", coord: Coordinate(lat: 0, lon: 0)),
            City(_id: 1, name: "Albuquerque", country: "US", coord: Coordinate(lat: 1, lon: 1)),
            City(_id: 2, name: "Amsterdam", country: "NL", coord: Coordinate(lat: 2, lon: 2)),
            City(_id: 3, name: "Sydney", country: "AU", coord: Coordinate(lat: 3, lon: 3))
        ]
        searcher = CitySearch(cities: cities)
    }

    func testEmptyPrefixReturnsAll() {
        let result = searcher.search(prefix: "")
        XCTAssertEqual(result.count, 4)
    }

    func testSingleLetter() {
        let a = searcher.search(prefix: "A")
        XCTAssertEqual(a.map(\.name), ["Alabama","Albuquerque","Amsterdam"])
    }

    func testCaseInsensitive() {
        let s = searcher.search(prefix: "s")
        XCTAssertEqual(s.map(\.name), ["Sydney"])
    }

    func testLongerPrefix() {
        let al = searcher.search(prefix: "Al")
        XCTAssertEqual(al.map(\.name), ["Alabama","Albuquerque"])
        let alb = searcher.search(prefix: "Alb")
        XCTAssertEqual(alb.map(\.name), ["Albuquerque"])
    }
}

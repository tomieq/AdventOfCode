//
//  ClosedRangeTests.swift
//
//
//  Created by Tomasz on 15/12/2022.
//

import Foundation
import XCTest
@testable import AdventOfCode

class ClosedRangeTests: XCTestCase {
    func test_combine() {
        XCTAssertEqual((1...4).combine(2...6), [1...6])
        XCTAssertEqual((2...6).combine(1...4), [1...6])
        XCTAssertEqual((1...4).combine(0...4), [0...4])
        XCTAssertEqual((1...4).combine(5...7), [1...7])
        XCTAssertEqual((5...7).combine(1...4), [1...7])
        XCTAssertEqual((1...4).combine(7...10), [1...4, 7...10])
    }

    func test_without() {
        XCTAssertEqual((10...20).without(15), [10...14, 16...20])
        XCTAssertEqual((10...20).without(20), [10...19])
        XCTAssertEqual((10...20).without(10), [11...20])
        XCTAssertEqual((10...20).without(30), [10...20])
        XCTAssertEqual((10...10).without(10), [])
    }
}

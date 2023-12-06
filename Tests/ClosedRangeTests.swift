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
    
    func test_chunk() {
        XCTAssertEqual((0...9).chunked(by: 5), [0...4, 5...9])
        XCTAssertEqual((1...9).chunked(by: 3), [1...3, 4...6, 7...9])
        XCTAssertEqual((10...19).chunked(by: 5), [10...14, 15...19])
        XCTAssertEqual((10...20).chunked(by: 5), [10...14, 15...19, 20...20])
        XCTAssertEqual((0...9).chunked(by: 50), [0...9])
        XCTAssertEqual((1...100).chunked(by: 60), [1...60, 61...100])
        
        XCTAssertEqual(ClosedRange.combine((10...19).chunked(by: 5)), [(10...19)])
    }
}

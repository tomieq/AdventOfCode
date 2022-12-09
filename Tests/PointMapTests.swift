//
//  PointMapTests.swift
//
//
//  Created by Tomasz on 08/12/2022.
//

import Foundation
import XCTest
@testable import AdventOfCode

class PointMapTests: XCTestCase {
    func test_valuesToDirection() {
        let input = """
        12345
        67890
        44444
        """
        let map = PointMap(input)
        XCTAssertEqual(map.values(from: Point(x: 1, y: 1), to: .right), [7, 8, 9, 0])
        XCTAssertEqual(map.values(from: Point(x: 3, y: 0), to: .left), [4, 3, 2, 1])
        XCTAssertEqual(map.values(from: Point(x: 2, y: 1), to: .up), [8, 3])
        XCTAssertEqual(map.values(from: Point(x: 0, y: 1), to: .down), [6, 4])
    }

    func test_valuesFromDirection() {
        let input = """
        12345
        67890
        44444
        """
        let map = PointMap(input)
        XCTAssertEqual(map.values(from: .left, to: Point(x: 3, y: 1)), [6, 7, 8, 9])
    }
}

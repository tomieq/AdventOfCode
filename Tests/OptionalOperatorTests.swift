//
//  OptionalOperatorTests.swift
//
//
//  Created by Tomasz on 01/12/2022.
//

import Foundation
import XCTest
@testable import AdventOfCode

final class OptionalOperatorTests: XCTestCase {
    func test_addOptionalInt() {
        var number = 100
        var addition: Int?
        number += addition
        XCTAssertEqual(number, 100)
        addition = 3
        number += addition
        XCTAssertEqual(number, 103)
    }

    func test_substractOptionalInt() {
        var number = 100
        var addition: Int?
        number -= addition
        XCTAssertEqual(number, 100)
        addition = 3
        number -= addition
        XCTAssertEqual(number, 97)
    }

    func test_compareOptionalInt() {
        let number = 100
        var other: Int?
        XCTAssertFalse(number > other)
        XCTAssertFalse(other > number)
        other = 99
        XCTAssertTrue(number > other)
        XCTAssertFalse(other > number)
        other = nil
        XCTAssertFalse(number < other)
        XCTAssertFalse(other < number)
        other = 102
        XCTAssertTrue(number < other)
        XCTAssertFalse(other < number)
    }
}

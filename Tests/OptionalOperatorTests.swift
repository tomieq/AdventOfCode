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
        XCTAssertEqual(12 + nil, 12)
        XCTAssertEqual(nil + 12, 12)
        XCTAssertEqual(nil + nil, 0)
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

    func test_multiplyOptionalInt() {
        var optional: Int? = nil
        XCTAssertEqual(optional * 10, 0)
        XCTAssertEqual(10 * optional, 0)
        XCTAssertEqual(optional * optional, 0)
        optional = 2
        XCTAssertEqual(optional * 10, 20)
        XCTAssertEqual(10 * optional, 20)
        XCTAssertEqual(optional * optional, 4)
    }
}

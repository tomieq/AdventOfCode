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
}

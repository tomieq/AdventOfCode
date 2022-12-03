//
//  StringExtensionTests.swift
//
//
//  Created by Tomasz on 03/12/2022.
//

import XCTest
@testable import AdventOfCode

final class StringExtensionTests: XCTestCase {
    func test_commonLetters() {
        let one = "vJrwpWtwJgWr"
        let two = "hcsFMMfFFhFp"
        XCTAssertEqual(one.commonLetters(with: two), "p")
    }

    func test_cutHalf() {
        let text = "vJrwpWtwJgWrhcsFMMfFFhFp"
        XCTAssertEqual(text.cut(into: 2), ["vJrwpWtwJgWr", "hcsFMMfFFhFp"])
        XCTAssertEqual("123456789".cut(into: 3), ["123", "456", "789"])
        XCTAssertEqual("12345678".cut(into: 4), ["12", "34", "56", "78"])
    }
}

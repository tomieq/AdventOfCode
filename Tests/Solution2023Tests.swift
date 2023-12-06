//
//  Solution2022Tests.swift
//
//
//  Created by Tomasz on 06/12/2023.
//

import XCTest
@testable import AdventOfCode

final class Solution2023Tests: XCTestCase {
    let absolutePath = "/Users/tomaskuc/dev/AdventOfCode/puzzles/2023/"
    func testInput(day: Int) -> String? {
        var dayNumber = "\(day)"
        if dayNumber.count == 1 {
            dayNumber = "0" + dayNumber
        }
        return Resource.getInput(absolutePath: self.absolutePath + "day\(dayNumber)/test.txt")
    }

    func prodInput(day: Int) -> String? {
        var dayNumber = "\(day)"
        if dayNumber.count == 1 {
            dayNumber = "0" + dayNumber
        }
        return Resource.getInput(absolutePath: self.absolutePath + "day\(dayNumber)/input.txt")
    }

    func test_day1() throws {
        let input = self.prodInput(day: 1) ?? ""
        let result1 = Solution2023().sumOfNumbers(input: input)
        XCTAssertEqual(result1, 55029)
    }
}

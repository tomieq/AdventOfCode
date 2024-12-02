//
//  Solution2022Tests.swift
//
//
//  Created by Tomasz on 06/12/2023.
//

import XCTest
@testable import AdventOfCode

final class Solution2024Tests: XCTestCase {
    let absolutePath = "/Users/tomaskuc/dev/AdventOfCode/puzzles/2024/"
    func testInput(day: Int, suffix: String = "") -> String? {
        var dayNumber = "\(day)"
        if dayNumber.count == 1 {
            dayNumber = "0" + dayNumber
        }
        return Resource.getInput(absolutePath: self.absolutePath + "day\(dayNumber)/test\(suffix).txt")
    }

    func prodInput(day: Int, suffix: String = "") -> String? {
        var dayNumber = "\(day)"
        if dayNumber.count == 1 {
            dayNumber = "0" + dayNumber
        }
        return Resource.getInput(absolutePath: self.absolutePath + "day\(dayNumber)/input\(suffix).txt")
    }

    func test_day1() throws {
        let input = self.prodInput(day: 1) ?? ""
//        let input = self.testInput(day: 1) ?? ""
        
        let result1 = Solution2024().twoLists(input: input)
        XCTAssertEqual(result1, 2066446)
        let result2 = Solution2024().twoListsFixed(input: input)
        XCTAssertEqual(result2, 24931009)
    }

}

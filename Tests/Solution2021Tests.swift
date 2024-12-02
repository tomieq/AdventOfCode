//
//  Solution2021Tests.swift
//
//
//  Created by Tomasz on 05/12/2022.
//

import XCTest
@testable import AdventOfCode

final class Solution2021Tests: XCTestCase {
    let absolutePath = "/Users/tomaskuc/dev/AdventOfCode/puzzles/2021/"
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
        let result1 = Solution2021().amountOfIncreasedNumber(input: input)
        XCTAssertEqual(result1, 1521)
        let result2 = Solution2021().amountOfIncreasedNumbersWindowed(input: input)
        XCTAssertEqual(result2, 1543)
    }

    func test_day2() throws {
        let input = self.prodInput(day: 2) ?? ""
        let result1 = Solution2021().travelling2dMap(input: input)
        XCTAssertEqual(result1, 1936494)
        let result2 = Solution2021().travelling2dMap2(input: input)
        XCTAssertEqual(result2, 1997106066)
    }

    func test_day3() throws {
        let input = self.prodInput(day: 3) ?? ""
        let result1 = Solution2021().mostCommonBitCounter(input: input)
        XCTAssertEqual(result1, 1307354)
        let result2 = Solution2021().bitFiltering(input: input)
        XCTAssertEqual(result2, 482500)
    }

    func test_day15() throws {
        let input = self.prodInput(day: 15) ?? ""
        //        let result1 = Solution2021().shortestWay(input: input)
        //        XCTAssertEqual(result1,
//        let result2 = Solution2021().shortestWayBiggerMap(input: input)
//                XCTAssertEqual(result2, 410)
    }

    func test_day16() throws {
        let input = self.testInput(day: 16) ?? ""
        let result1 = Solution2021().day16(input: input)
    }
}

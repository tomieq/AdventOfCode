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
        let result1 = Solution2023().sumOfNumbers(input: input)
        XCTAssertEqual(result1, 55029)
        let result2 = Solution2023().sumOfTextNumbers(input: input)
        XCTAssertEqual(result2, 55686)
    }

    func test_day2() throws {
        let input = self.prodInput(day: 2) ?? ""
        let result1 = Solution2023().cubeGame(input: input)
        XCTAssertEqual(result1, 2879)
        let result2 = Solution2023().cubeGame2(input: input)
        XCTAssertEqual(result2, 65122)
    }
    
    func test_day4() throws {
        let input = self.prodInput(day: 4) ?? ""
        let result1 = Solution2023().scratchcardsGame(input: input)
        XCTAssertEqual(result1, 21088)
        let result2 = Solution2023().scratchcardsGame2(input: input)
        XCTAssertEqual(result2, 6874754)
    }
    
    func test_day6() throws {
        let input = self.prodInput(day: 6) ?? ""
        let result1 = Solution2023().boatRace(input: input)
        XCTAssertEqual(result1, 503424)
        let result2 = Solution2023().boatRace2(input: input)
        XCTAssertEqual(result2, 32607562)
    }
}

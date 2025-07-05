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
    
    func test_day2() throws {
        let input = self.prodInput(day: 2) ?? ""
//        let input = self.testInput(day: 2) ?? ""
        
        let result1 = Solution2024().reactorReports(input: input)
        XCTAssertEqual(result1, 524)
        let result2 = Solution2024().reactorReportsFixed(input: input)
        XCTAssertEqual(result2, 569)
    }
    
    func test_day3() throws {
        let input = self.prodInput(day: 3) ?? ""
//        let input = self.testInput(day: 3) ?? ""
        
        let result1 = Solution2024().cpuInstructions(input: input)
        XCTAssertEqual(result1, 178794710)
        let result2 = Solution2024().cpuInstructionsWithEnabling(input: input)
        XCTAssertEqual(result2, 76729637)
    }
    
    func test_day4() throws {
//        let input = self.prodInput(day: 3) ?? ""
        let input = self.testInput(day: 4) ?? ""
        
        let result1 = Solution2024().findText(input: input)
//        XCTAssertEqual(result1, 178794710)
//        let result2 = Solution2024().cpuInstructionsWithEnabling(input: input)
//        XCTAssertEqual(result2, 76729637)
    }

}

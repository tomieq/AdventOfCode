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
    
    func test_day3() throws {
        let input = self.prodInput(day: 3) ?? ""
        let result1 = Solution2023().engine(input: input)
        XCTAssertEqual(result1, 532331)
        let result2 = Solution2023().engine2(input: input)
        XCTAssertEqual(result2, 82301120)
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
    
    func test_day7() throws {
        let input = self.prodInput(day: 7) ?? ""
        let result1 = Solution2023().camelCards(input: input)
        XCTAssertEqual(result1, 251216224)
        let result2 = Solution2023().camelCards2(input: input)
        XCTAssertEqual(result2, 250825971)
    }

    func test_day8() throws {
        let input = self.prodInput(day: 8) ?? ""
        let result1 = Solution2023().crawlInstructions(input: input)
        XCTAssertEqual(result1, 18157)
        let result2 = Solution2023().crawlInstructions2(input: input)
        XCTAssertEqual(result2, 14299763833181)
    }

    func test_day9() throws {
        let input = self.prodInput(day: 9) ?? ""
        let result1 = Solution2023().numberSequence(input: input)
        XCTAssertEqual(result1, 1725987467)
        let result2 = Solution2023().numberSequence2(input: input)
        XCTAssertEqual(result2, 971)
    }
    
    func test_day10() throws {
        let input = self.prodInput(day: 10) ?? ""
        let result1 = Solution2023().crawlingPipes(input: input)
        XCTAssertEqual(result1, 6951)
    }
    
    func test_day11() throws {
        let input = self.prodInput(day: 11) ?? ""
        let result1 = Solution2023().spaceShortestWay(input: input)
        XCTAssertEqual(result1, 10228230)
        let result2 = Solution2023().spaceShortestWay2(input: input)
        XCTAssertEqual(result2, 447073334102)
    }
}

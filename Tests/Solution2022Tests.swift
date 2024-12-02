//
//  Solution2022Tests.swift
//
//
//  Created by Tomasz on 05/12/2022.
//

import XCTest
@testable import AdventOfCode

final class Solution2022Tests: XCTestCase {
    let absolutePath = "/Users/tomaskuc/dev/AdventOfCode/puzzles/2022/"
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
        let result1 = Solution2022().maxSumOfGroup(input: input)
        XCTAssertEqual(result1, 72718)
        let result2 = Solution2022().top3MaxSumOfGroup(input: input)
        XCTAssertEqual(result2, 213089)
    }

    func test_day2() throws {
        let input = self.prodInput(day: 2) ?? ""
        let result1 = Solution2022().paperGameScore(input: input)
        XCTAssertEqual(result1, 15422)
        let result2 = Solution2022().paperGameCommand(input: input)
        XCTAssertEqual(result2, 15442)
    }

    func test_day3() throws {
        let input = self.prodInput(day: 3) ?? ""
        let result1 = Solution2022().arrayCommonLetters1(input: input)
        XCTAssertEqual(result1, 8349)
        let result2 = Solution2022().arrayCommonLetters2(input: input)
        XCTAssertEqual(result2, 2681)
    }

    func test_day4() throws {
        let input = self.prodInput(day: 4) ?? ""
        let result1 = Solution2022().containingRanges(input: input)
        XCTAssertEqual(result1, 605)
        let result2 = Solution2022().overlappingRanges(input: input)
        XCTAssertEqual(result2, 914)
    }

    func test_day5() throws {
        let input = self.prodInput(day: 5) ?? ""
        let result1 = Solution2022().movingNumbersBetweenArrays(input: input)
        XCTAssertEqual(result1, "JRVNHHCSJ")
        let result2 = Solution2022().movingMultipleNumbersBetweenArrays(input: input)
        XCTAssertEqual(result2, "GNFBSBJLH")
    }

    func test_day6() throws {
        let input = self.prodInput(day: 6) ?? ""
        let result1 = Solution2022().searchingFirstUniqueSequence1(input: input)
        XCTAssertEqual(result1, 1912)
        let result2 = Solution2022().searchingFirstUniqueSequence2(input: input)
        XCTAssertEqual(result2, 2122)
    }

    func test_day7() throws {
        let input = self.prodInput(day: 7) ?? ""
        let result1 = Solution2022().directoryCrawling1(input: input)
        XCTAssertEqual(result1, 1447046)
        let result2 = Solution2022().directoryCrawling2(input: input)
        XCTAssertEqual(result2, 578710)
    }

    func test_day8() throws {
        let input = self.prodInput(day: 8) ?? ""
        let result1 = Solution2022().topPointOnTheMap1(input: input)
        XCTAssertEqual(result1, 1719)
        let result2 = Solution2022().topPointOnTheMap2(input: input)
        XCTAssertEqual(result2, 590824)
    }

    func test_day9() throws {
        let input = self.prodInput(day: 9) ?? ""
        let result1 = Solution2022().chasingPointOnMap1(input: input)
        XCTAssertEqual(result1, 5883)
        let result2 = Solution2022().chasingPointOnMap2(input: input)
        XCTAssertEqual(result2, 2367)
    }

    func test_day11() throws {
        let input = self.prodInput(day: 11) ?? ""
        let result1 = Solution2022().primeNumbers1(input: input)
        XCTAssertEqual(result1, 182293)
        let result2 = Solution2022().primeNumbers2(input: input)
        XCTAssertEqual(result2, 54832778815)
    }

    func test_day13() throws {
        let input = self.prodInput(day: 13) ?? ""
        let result1 = Solution2022().parsingArray1(input: input)
        XCTAssertEqual(result1, 5196)
        let result2 = Solution2022().parsingArray2(input: input)
        XCTAssertEqual(result2, 22134)
    }

    func test_day14() throws {
        let input = self.prodInput(day: 14) ?? ""
        let result1 = Solution2022().sandPouring1(input: input)
        XCTAssertEqual(result1, 1061)
        let result2 = Solution2022().sandPouring2(input: input)
        XCTAssertEqual(result2, 25055)
    }

    func test_day15() throws {
        let input = self.prodInput(day: 15) ?? ""
        let result1 = Solution2022().sensorBeaconRange1(input: input)
        XCTAssertEqual(result1, 5240818)
        let result2 = Solution2022().sensorBeaconRange2(input: input)
        XCTAssertEqual(result2, 13213086906101)
    }

    func test_day25a() throws {
        let input = self.testInput(day: 25) ?? ""
        let result1 = Solution2022().day25a(input: input)
    }
}

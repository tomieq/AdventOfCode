//
//  RunTests.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

import Foundation
import XCTest
@testable import AdventOfCode

final class RunTests: XCTestCase {
    func test_run2021() throws {
        let inputPath = "/Users/tomaskuc/dev/AdventOfCode/puzzles/2021/day14/input.txt"
        guard let input = Resource.getInput(absolutePath: inputPath) else {
            Logger.e("Main", "No input data!")
            return
        }

        let solution = Solution2021()
        Logger.v("Run", "-------------------------")
        solution.chemicalFormuaeLong(input: input)
        Logger.v("Run", "-------------------------")
    }

    func test_run2022() throws {
        let inputPath = "/Users/tomaskuc/dev/AdventOfCode/puzzles/2022/day03/test.txt"
        guard let input = Resource.getInput(absolutePath: inputPath) else {
            Logger.e("Main", "No input data!")
            return
        }

        let solution = Solution2022()
        Logger.v("Run", "-------------------------")
//        solution.groupedBackpackLetters(input: input)
        Logger.v("Run", "-------------------------")
    }

    func test_BingoCard() {
        let card = BingoCard(numbers: [1, 2, 3, 4, 5, 6, 7, 8, 9], size: 3)

        XCTAssertFalse(card.didWin)
        card.markedNumbers.append(contentsOf: [4, 5, 6])
        XCTAssertTrue(card.didWin)

        card.markedNumbers = [1, 4]
        XCTAssertFalse(card.didWin)
        card.markedNumbers.append(contentsOf: [7])
        XCTAssertTrue(card.didWin)
    }
}

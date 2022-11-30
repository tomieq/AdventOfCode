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

    func test_Point() {
        var start = Point(x: 9, y: 0)
        var end = Point(x: 0, y: 9)
        print(end.diagonalLine(to: start))
    }
}

//
//  BingoCard.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

import Foundation

class BingoCard: CustomStringConvertible, Equatable {
    let size: Int
    let numbers: [[Int]]
    var markedNumbers: [Int] = []

    init(numbers: [Int], size: Int = 5) {
        self.size = size
        self.numbers = numbers.chunked(by: self.size)
    }

    var description: String {
        "\(self.numbers)"
    }

    var unmarkedNumbers: [Int] {
        self.numbers.flatMap{ $0 }.filter { !self.markedNumbers.contains($0) }
    }

    var didWin: Bool {
        // check rows
        for row in 0..<self.size {
            let isRowWinning = self.numbers[row].reduce(true) { current, number in
                current && self.markedNumbers.contains(number)
            }
            if isRowWinning {
                return true
            }
        }
        for position in 0..<self.size {
            var numbersInColumn: [Int] = []
            for row in 0..<self.size {
                numbersInColumn.append(self.numbers[row][position])
            }
            let isPositionWinning = numbersInColumn.reduce(true) { current, number in
                current && self.markedNumbers.contains(number)
            }
            if isPositionWinning {
                return true
            }
        }
        return false
    }

    static func == (lhs: BingoCard, rhs: BingoCard) -> Bool {
        lhs.numbers == rhs.numbers
    }
}

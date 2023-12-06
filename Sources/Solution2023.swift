//
//  Solution2021.swift
//
//
//  Created by Tomasz on 06/12/2023.
//

// group folding: Shift + option + command + left/right arrow

import Foundation

class Solution2023 {
    private let logTag = "Solution2023"

    // MARK: Day 1 - part 1
    func sumOfNumbers(input: String) -> Int {
        let result = input.split("\n")
            .filter { !$0.isEmpty }
            .map {
                let onlyNumbers = $0.array.compactMap { $0.decimal }
                return onlyNumbers.first * 10 + onlyNumbers.last
            }
            .reduce(0, +)

        Logger.v(self.logTag, "Result = \(result)")
        return result
    }

}

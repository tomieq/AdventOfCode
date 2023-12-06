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

    // MARK: Day 1 - part 2
    func sumOfTextNumbers(input: String) -> Int {
        class LineParser {
            let line: String
            let mapping = [
                "one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9
            ]
            
            init(line: String) {
                self.line = line
            }
            var digits: [Int] {
                var result: [Int] = []
                var position = 0
                while position < self.line.count {
                    if let digit = line.array[position].decimal {
                        result.append(digit)
                        position.increment()
                        continue
                    }
                    for (text, value) in self.mapping {
                        if text == line.subString(position, position + text.count) {
                            result.append(value)
                            position.increment()
                            continue
                        }
                    }
                    position.increment()
                }
                return result
            }
        }
        
        let result = input.split("\n")
            .filter { !$0.isEmpty }
            .map {
                let parser = LineParser(line: $0)
                let digits = parser.digits
                return digits.first * 10 + digits.last
            }
            .reduce(0, +)

        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 2 - part 1
    func cubeGame(input: String) -> Int {
        let result = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
            .compactMap { text -> Int? in
                let parts = text.split(":")
                let game = parts[0].removed(text: "Game ").decimal
                let rounds = parts[1].split(";")
                for round in rounds {
                    let entries = round.trimmed.split(",")
                    for entry in entries {
                        let (amountTxt, color) = entry.trimmed.split(" ").tuple
                        let amount = amountTxt.decimal!
                        switch color {
                        case "red":
                            if amount > 12 {
                                return nil
                            }
                        case "green":
                            if amount > 13 {
                                return nil
                            }
                        case "blue":
                            if amount > 14 {
                                return nil
                            }
                        default:
                            break
                        }
                    }
                }
                return game
            }
            .reduce(0, +)

        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
}

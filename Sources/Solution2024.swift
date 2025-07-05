//
//  Solution2024.swift
//  AdventOfCode
//
//  Created by Tomasz on 02/12/2024.
//

// group folding: Shift + option + command + left/right arrow

import Foundation

class Solution2024 {
    private let logTag = "Solution2024"
    
    // MARK: Day 1 - part 1
    func twoLists(input: String) -> Int {
        var leftList: [Int] = []
        var rightList: [Int] = []
        input.split("\n")
            .filter { !$0.isEmpty }
            .forEach {
                let parts = $0.split("   ").tuple
                leftList.append(parts.0.decimal)
                rightList.append(parts.1.decimal)
            }
        leftList.sort()
        rightList.sort()
        let result = leftList.enumerated()
            .map{ abs($0.element - rightList[$0.offset]) }
            .reduce(0, +)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 1 - part 2
    func twoListsFixed(input: String) -> Int {
        var leftList: [Int] = []
        var rightList: [Int] = []
        input.split("\n")
            .filter { !$0.isEmpty }
            .forEach {
                let parts = $0.split("   ").tuple
                leftList.append(parts.0.decimal)
                rightList.append(parts.1.decimal)
            }
        
        let result = leftList.map { number in
            rightList.count{ $0 == number} * number
        }.reduce(0, +)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 2 - part 1
    func reactorReports(input: String) -> Int {
        let result = input.split("\n")
            .filter { !$0.isEmpty }
            .map {
                $0.split(" ").compactMap{ $0.decimal }
            }
            .map { list in
                list.enumerated()
                .compactMap { (offset, element) -> Int? in
                    guard let nextNumber = list[safeIndex: offset.incremented] else {
                        return nil
                    }
                    return element - nextNumber
                }
            }.filter { list in
                list.allSatisfy { (1...3).contains(abs($0)) }
            }.filter { list in
                list.allSatisfy { $0 > 0} || list.allSatisfy { $0 < 0}
            }.count
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 2 - part 2
    func reactorReportsFixed(input: String) -> Int {
        func isReportSafe(_ numbers: [Int]) -> Bool {
            let diff = numbers.enumerated()
            .compactMap { (offset, element) -> Int? in
                guard let nextNumber = numbers[safeIndex: offset.incremented] else {
                    return nil
                }
                return element - nextNumber
            }
            return diff.allSatisfy { (1...3).contains(abs($0)) } && (diff.allSatisfy { $0 > 0} || diff.allSatisfy { $0 < 0})
        }
        let result = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.split(" ").compactMap{ $0.decimal } }
            .filter { list in
                if isReportSafe(list) {
                    return true
                }
                for index in (0..<list.count) {
                    if isReportSafe(list.removed(index: index)) {
                        return true
                    }
                }
                return false
            }.count
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 3 - part 1
    func cpuInstructions(input: String) -> Int {
        var result = 0
        do {
            let pattern = #"mul\(\d+,\d+\)"#
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            
            let matches = regex.matches(in: input, options: [], range: NSRange(input.startIndex..., in: input))
            
            result =  matches.map {
                String(input[Range($0.range, in: input)!])
            }.map {
                $0.removed(text: "mul(")
                    .removed(text: ")")
                    .split(",")
                    .compactMap{ $0.decimal }
                    .reduce(1, *)
            }.reduce(0, +)
        } catch {
            print("Error: \(error)")
        }
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 3 - part 2
    func cpuInstructionsWithEnabling(input: String) -> Int {
        var text = input
        var result = 0
        while let disableIndex = text.indexOf("don't()") {
            result += cpuInstructions(input: text.subString(0, disableIndex))
            text = text.subString(disableIndex + 7, text.count)
            if let enableIndex = text.indexOf("do()") {
                text = text.subString(enableIndex, text.count)
            }
        }
        result += cpuInstructions(input: text)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 4 - part 1
    func findText(input: String) -> Int {

        var result = 0
        var map: [Point: String] = [:]
        let lines = input.split("\n").filter{ !$0.isEmpty }
        for (y, line) in lines.enumerated() {
            for (x, value) in line.array.enumerated() {
                map[Point(x: x, y: y)] = value
            }
        }
        func nextLetterPoint(point: Point, remainingLetters: String, direction: MoveDirection){
            guard let letter = remainingLetters[safeIndex: 0]?.string else {
                result.increment()
                return
            }
            guard map[point] == letter else {
                return
            }
            let restLetters = String(remainingLetters.dropFirst())
            nextLetterPoint(point: point.move(direction), remainingLetters: restLetters, direction: direction)
        }
        map.filter{ $0.value == "X" }.forEach {

            for direction in MoveDirection.allCases {
                nextLetterPoint(point: $0.key.move(direction),
                                remainingLetters: "MAS",
                                direction: direction)
            }
        }
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
}

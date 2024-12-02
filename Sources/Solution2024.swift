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
}

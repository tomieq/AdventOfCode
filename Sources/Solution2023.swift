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
    
    // MARK: Day 2 - part 2
    func cubeGame2(input: String) -> Int {
        let result = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
            .compactMap { text -> Int? in
                let parts = text.split(":")
                let rounds = parts[1].split(";")
                var stats: [String: Int] = [:]
                for round in rounds {
                    let entries = round.trimmed.split(",")
                    for entry in entries {
                        let (amountTxt, color) = entry.trimmed.split(" ").tuple
                        let amount = amountTxt.decimal!
                        stats[color] = max(amount, stats[color, default: amount])
                    }
                }
                return stats["red"] * stats["blue"] * stats["green"]
            }
            .reduce(0, +)

        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 3 - part 1
    func engine(input: String) -> Int {
        
        var map: [Point: String] = [:]
        let lines = input.split("\n").filter{ !$0.isEmpty }
        for (y, line) in lines.enumerated() {
            for (x, value) in line.array.enumerated() {
                map[Point(x: x, y: y)] = value
            }
        }
        let engineParts = map.filter { $0.value != "." && $0.value.decimal.isNil }
        
        var partNumbers: [Int] = []
        var textNumber = ""
        var isPartNumber = false
        for (y, line) in lines.enumerated() {
            for (x, value) in line.array.enumerated() {
                if value.decimal.notNil {
                    textNumber.append(value)
                    let point = Point(x: x, y: y)
                    let neighbourPoints = point.linearNeighbours + point.diagonalNeighbours
                    if neighbourPoints.hasCommonElements(with: engineParts.rawKeys) {
                        isPartNumber = true
                    }
                } else if !textNumber.isEmpty {
                    if isPartNumber {
                        partNumbers.append(textNumber.decimal!)
                    }
                    textNumber = ""
                    isPartNumber = false
                }
            }
        }
        let result = partNumbers.reduce(0, +)

        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 3 - part 2
    func engine2(input: String) -> Int {
        
        var map: [Point: String] = [:]
        let lines = input.split("\n").filter{ !$0.isEmpty }
        for (y, line) in lines.enumerated() {
            for (x, value) in line.array.enumerated() {
                map[Point(x: x, y: y)] = value
            }
        }
        let gearPoints = map.filter { $0.value == "*" }.map { $0.key }
        var gearStat: [Point: [Int]] = [:]
        
        var textNumber = ""
        var connectedGear: Point? = nil
        for (y, line) in lines.enumerated() {
            for (x, value) in line.array.enumerated() {
                if value.decimal.notNil {
                    textNumber.append(value)
                    let point = Point(x: x, y: y)
                    let neighbourPoints = point.linearNeighbours + point.diagonalNeighbours
                    let partPoints = neighbourPoints.commonElements(with: gearPoints)
                    if partPoints.isEmpty.not {
                        connectedGear = partPoints.first!
                    }
                } else if !textNumber.isEmpty {
                    if let connectedGear = connectedGear {
                        gearStat[connectedGear, default: []].append(textNumber.decimal!)
                    }
                    textNumber = ""
                    connectedGear = nil
                }
            }
        }
        let ratios = gearStat.filter { $0.value.count == 2 } .map { $0.value.reduce(1, *) }
        let result = ratios.reduce(0, +)

        Logger.v(self.logTag, "Result = \(result)")
        return result
    }

    // MARK: Day 4 - part 1
    func scratchcardsGame(input: String) -> Int {
        let result = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
            .map { text in
                let parts = text.split(":")
                let (left, right) = parts[1].trimmed.split("|").tuple
                let winningNumbers = left.trimmed.split(" ").filter { !$0.isEmpty }
                let playerNumbers = right.trimmed.split(" ").filter { !$0.isEmpty }
                let matchingNumbers = playerNumbers.commonElements(with: winningNumbers)
                return matchingNumbers
            }
            .map {
                let matchAmount = $0.count
                switch matchAmount {
                case 0:
                    return 0
                case 1:
                    return 1
                default:
                    var score = 1
                    (0..<matchAmount.decremented).forEach { _ in score *= 2 }
                    return score
                }
            }
            .reduce(0, +)

        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 4 - part 2
    func scratchcardsGame2(input: String) -> Int {
        let wonCopies = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
            .map { text in
                let parts = text.split(":")
                let (left, right) = parts[1].trimmed.split("|").tuple
                let winningNumbers = left.trimmed.split(" ").filter { !$0.isEmpty }
                let playerNumbers = right.trimmed.split(" ").filter { !$0.isEmpty }
                let matchingNumbers = playerNumbers.commonElements(with: winningNumbers)
                return matchingNumbers.count
            }
        print(wonCopies.enumerated().map{ "card \($0.offset + 1): \($0.element)" })
        
        var sumOfCopies: [Int: Int] = [:]
        func numberOfCopies(at index: Int) -> Int {
            if wonCopies[index] == 0 {
                sumOfCopies[index] = 0
                return 0
            }
            let copyIndexes = index + 1 ... index + wonCopies[index]
            let sum = wonCopies[index] + copyIndexes.compactMap{ sumOfCopies[$0] }.reduce(0, +)
            sumOfCopies[index] = sum
            print("card \(index + 1) won \(sum) cards")
            return sum
        }

        var result = wonCopies.count
        var i = wonCopies.count.decremented
        while i >= 0 {
            result += numberOfCopies(at: i)
            i.decrement()
        }
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 5 - part 1
    func soilMapper(input: String) -> Int {
        let lines = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
        class Rule: CustomStringConvertible {
            let name: String
            let from: String
            let to: String
            var lines: [String] = []
            init(name: String) {
                self.name = name
                let parts = name.split("-to-")
                self.from = parts[0]
                self.to = parts[1]
            }
            var description: String {
                "name: \(name), lines: \(lines)"
            }
            func convert(_ input: Int) -> Int {
                for line in lines {
                    let (destinationStart, sourceStart, length) = line.split(" ").compactMap { $0.decimal }.triple
                    if (sourceStart..<sourceStart + length).contains(input) {
                        let diff = sourceStart - destinationStart
                        return input - diff
                    }
                }
                return input
            }
        }
        
        var seeds: [Int] = []
        var rules: [Rule] = []
        var currentRule: Rule?
        for line in lines {
            if line.hasPrefix("seeds:") {
                seeds = line.removed(text: "seeds:").trimmed.split(" ").compactMap{ $0.decimal }
            } else if line.hasSuffix("map:") {
                let name = line.removed(text: "map:").trimmed
                let rule = Rule(name: name)
                currentRule = rule
                rules.append(rule)
            } else if let rule = currentRule {
                rule.lines.append(line.trimmed)
            }
        }

        var closestLocation = Int.max
        for seed in seeds {
            var from = "seed"
            var converted = seed
            while true {
                let rule = rules.first{ $0.from == from }!
                from = rule.to
                converted = rule.convert(converted)
//                print("rule \(rule.name) converted into: \(converted)")
                if rule.to == "location" {
                    closestLocation = min(closestLocation, converted)
                    break
                }
            }
        }
//        let test = rules.first{ $0.name == "seed-to-soil" }?.convert(99)
        Logger.v(self.logTag, "Result = \(closestLocation)")
        return closestLocation
    }

    // MARK: Day 6 - part 1
    func boatRace(input: String) -> Int {
        let lines = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
        
        let times = lines[0].removed(text: "Time:").trimmed.split(" ").filter { !$0.isEmpty }
        let distance = lines[1].removed(text: "Distance:").trimmed.split(" ").filter { !$0.isEmpty }
        
        struct Race {
            let time: Int
            let distance: Int
        }
        let races = zip(times, distance).map { Race(time: $0.0.decimal!, distance: $0.1.decimal!) }
        let result = races.map { race in
            var counter = 0
            for speed in 0..<race.time {
                let distance = (race.time - speed) * speed
                if distance > race.distance {
                    counter.increment()
                }
            }
            return counter
        }.reduce(1, *)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 6 - part 2
    func boatRace2(input: String) -> Int {
        let lines = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
        
        let time = lines[0].removed(text: "Time:").trimmed.removed(text: " ").decimal
        let distance = lines[1].removed(text: "Distance:").trimmed.removed(text: " ").decimal
        
        struct Race {
            let time: Int
            let distance: Int
        }
        let race = Race(time: time!, distance: distance!)
        var result = 0
        for speed in 0..<race.time {
            let distance = (race.time - speed) * speed
            if distance > race.distance {
                result.increment()
            }
        }
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
}
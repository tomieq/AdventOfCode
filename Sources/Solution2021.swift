//
//  Solution2021.swift
//
//
//  Created by Tomasz on 29/11/2022.
//

import Foundation

class Solution2021 {
    private let logTag = "Solution2021"

    // MARK: Day 1 - part 1
    func sonarSweepDepthMeasurement(input: String) {
        let numbers = input.split("\n").filter { !$0.isEmpty }.compactMap { $0.decimal }
        var result = 0

        var previousNumber: Int?
        for number in numbers {
            guard let previous = previousNumber else {
                previousNumber = number
                continue
            }
            if previous < number {
                result += 1
            }
            previousNumber = number
        }
        Logger.v(self.logTag, "Result = \(result)")
    }

    // MARK: Day 1 - part 2
    func sonarSweepDepthMeasurementSmoothing(input: String) {
        let numbers = input.split("\n").filter { !$0.isEmpty }.compactMap { $0.decimal }

        var windowedNumbers: [Int] = []
        for (index, number) in numbers.enumerated() {
            guard let second = numbers[safeIndex: index + 1],
                  let third = numbers[safeIndex: index + 2] else {
                continue
            }
            windowedNumbers.append(number + second + third)
        }
        Logger.v(self.logTag, "Windowed numbers = \(windowedNumbers)")
        var result = 0

        var previousNumber: Int?
        for number in windowedNumbers {
            guard let previous = previousNumber else {
                previousNumber = number
                continue
            }
            if previous < number {
                result += 1
            }
            previousNumber = number
        }
        Logger.v(self.logTag, "Result = \(result)")
    }

    // MARK: Day 2 - part 1
    func diveHorizontanPosition(input: String) {
        let lines = input.split("\n")
        var horizontalPosition = 0
        var depth = 0

        for line in lines {
            let parts = line.split(" ")
            guard let command = parts[safeIndex: 0], let value = parts[safeIndex: 1]?.decimal else {
                continue
            }
            switch command {
            case "forward":
                horizontalPosition += value
            case "down":
                depth += value
            case "up":
                depth -= value
            default:
                Logger.e(self.logTag, "Invalid command \(command)")
            }
        }

        let result = horizontalPosition * depth

        Logger.v(self.logTag, "Result = \(result)")
    }

    // MARK: Day 2 - part 2
    func diveHorizontanPositionAndAim(input: String) {
        let lines = input.split("\n").filter { !$0.isEmpty }
        var horizontalPosition = 0
        var depth = 0
        var aim = 0

        for line in lines {
            let parts = line.split(" ")
            guard let command = parts[safeIndex: 0], let value = parts[safeIndex: 1]?.decimal else {
                continue
            }
            switch command {
            case "forward":
                horizontalPosition += value
                depth += aim * value
            case "down":
                aim += value
            case "up":
                aim -= value
            default:
                Logger.e(self.logTag, "Invalid command \(command)")
            }
        }

        let result = horizontalPosition * depth

        Logger.v(self.logTag, "Result = \(result)")
    }

    // MARK: Day 3 - part 1
    func binaryDiagnosticGammaAndOxygen(input: String) {
        let lines = input.split("\n").filter { !$0.isEmpty }
        let numberAmount = lines.count

        // counter keeping a number of ones per position
        var oneCounter: [Int: Int] = [:]
        for binary in lines {
            for (position, character) in binary.enumerated() {
                if character == "1" {
                    oneCounter[position, default: 0] += 1
                }
            }
        }
        var gammaRate = ""
        var epsilonRate = ""

        for index in 0...oneCounter.keys.count - 1 {
            if oneCounter[index, default: 0] > numberAmount / 2 {
                gammaRate.append("1")
                epsilonRate.append("0")
            } else {
                gammaRate.append("0")
                epsilonRate.append("1")
            }
        }
        Logger.v(self.logTag, "oneCounter: \(oneCounter)")
        Logger.v(self.logTag, "gammaRate: \(gammaRate) \(gammaRate.binary.readable)")
        Logger.v(self.logTag, "epsilonRate: \(epsilonRate) \(epsilonRate.binary.readable)")
        let result = (gammaRate.binary ?? 0) * (epsilonRate.binary ?? 0)

        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 3 - part 2
    func binaryDiagnosticOxygenAndCO2Scrubber(input: String) {
        let numbers = input.split("\n").filter { !$0.isEmpty }

        var oxygens = numbers

        let numberOfDigitsPerLine = numbers[0].count
        // oxygen
        var position = 0
        for _ in 1...numberOfDigitsPerLine {
            // find most common digit per position
            var oneCounter = 0
            let divider = oxygens.count * 10 / 2
            for number in oxygens {
                if number[position] == "1" {
                    oneCounter += 1
                }
            }
            let mostCommon = oneCounter * 10 >= divider ? "1" : "0"
            for number in oxygens {
                if number[position].string != mostCommon {
                    if oxygens.count > 1 {
                        oxygens.remove(object: number)
                    }
                }
            }
            position.increment()
        }

        var scrubbers = numbers
        position = 0
        for _ in 1...numberOfDigitsPerLine {
            var oneCounter = 0
            let divider = scrubbers.count * 10 / 2
            for number in scrubbers {
                if number[position] == "1" {
                    oneCounter += 1
                }
            }
            let mostCommon = oneCounter * 10 >= divider ? "1" : "0"
            for number in scrubbers {
                if number[position].string == mostCommon {
                    if scrubbers.count > 1 {
                        scrubbers.remove(object: number)
                    }
                }
            }
            position.increment()
        }

        let result = (oxygens.first?.binary ?? 0) * (scrubbers.first?.binary ?? 0)

        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 4 - part 1
    func giantSquidBingo(input: String) {
        let lines = input.split("\n").map { $0.trimming(" ") }
        let numbers = lines[0].split(",").compactMap { $0.decimal }

        let numberOfLines = lines.count

        var currentLine = 2

        var bingoCards: [BingoCard] = []
        while currentLine < numberOfLines - 1 {
            var bingoCardNumbers: [Int] = []
            for _ in 1...5 {
                let lineNumbers = lines[currentLine].split(" ").compactMap { $0.decimal }
                bingoCardNumbers.append(contentsOf: lineNumbers)
                currentLine.increment()
            }
            bingoCards.append(BingoCard(numbers: bingoCardNumbers))
            currentLine.increment()
        }
        for number in numbers {
            for bingoCard in bingoCards {
                bingoCard.markedNumbers.append(number)
                if bingoCard.didWin {
                    let sumOfUnmarked = bingoCard.unmarkedNumbers.reduce(0, +)
                    let result = sumOfUnmarked * number
                    Logger.v(self.logTag, "Result: \(result)")
                    return
                }
            }
        }
    }

    // MARK: Day 4 - part 2
    func giantSquidBingoLastWin(input: String) {
        let lines = input.split("\n").map { $0.trimming(" ") }
        let numbers = lines[0].split(",").compactMap { $0.decimal }

        let numberOfLines = lines.count

        var currentLine = 2

        var bingoCards: [BingoCard] = []
        while currentLine < numberOfLines - 1 {
            var bingoCardNumbers: [Int] = []
            for _ in 1...5 {
                let lineNumbers = lines[currentLine].split(" ").compactMap { $0.decimal }
                bingoCardNumbers.append(contentsOf: lineNumbers)
                currentLine.increment()
            }
            bingoCards.append(BingoCard(numbers: bingoCardNumbers))
            currentLine.increment()
        }
        var result: Int?
        for number in numbers {
            for bingoCard in bingoCards {
                bingoCard.markedNumbers.append(number)
                if bingoCard.didWin {
                    let sumOfUnmarked = bingoCard.unmarkedNumbers.reduce(0, +)
                    result = sumOfUnmarked * number
                    bingoCards.remove(object: bingoCard)
                    continue
                }
            }
        }
        Logger.v(self.logTag, "Result: \(result.readable)")
    }

    // MARK: Day 5 - part 1
    func hydrothermalVentureStraight(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var pointUsage: [Point: Int] = [:]
        for line in lines {
            let parts = line.split(" -> ")
            let leftCoordinates = parts[0].split(",").compactMap { $0.decimal }
            let rightCoordinates = parts[1].split(",").compactMap { $0.decimal }
            let startPoint = Point(x: leftCoordinates[0], y: leftCoordinates[1])
            let endPoint = Point(x: rightCoordinates[0], y: rightCoordinates[1])

            for point in startPoint.straightLine(to: endPoint) {
                pointUsage[point, default: 0].increment()
            }
        }

        var result = 0
        for data in pointUsage {
            if data.value >= 2 {
                result.increment()
            }
        }
        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 5 - part 2
    func hydrothermalVentureDiagonal(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var pointUsage: [Point: Int] = [:]
        for line in lines {
            let parts = line.split(" -> ")
            let leftCoordinates = parts[0].split(",").compactMap { $0.decimal }
            let rightCoordinates = parts[1].split(",").compactMap { $0.decimal }
            let startPoint = Point(x: leftCoordinates[0], y: leftCoordinates[1])
            let endPoint = Point(x: rightCoordinates[0], y: rightCoordinates[1])

            for point in startPoint.straightLine(to: endPoint) {
                pointUsage[point, default: 0].increment()
            }

            for point in startPoint.diagonalLine(to: endPoint) {
                pointUsage[point, default: 0].increment()
            }
        }

        var result = 0
        for data in pointUsage {
            if data.value >= 2 {
                result.increment()
            }
        }
        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 6 - part 1
    func lanternFishPopulation(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }
        let fishTimers = lines[0].split(",").compactMap { $0.decimal }

        let collection = LanternCollection()
        for fishTimer in fishTimers {
            collection.fish.append(LanternFish(timer: fishTimer))
        }
        for _ in 1...80 {
            for fish in collection.fish {
                fish.nextDay(collection: collection)
            }
        }
        Logger.v(self.logTag, "Result: \(collection.fish.count)")
    }

    // MARK: Day 6 - part 2
    func lanternFishPopulationAfter256Days(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }
        let fishTimers = lines[0].split(",").compactMap { $0.decimal }

        // map of fish amount by timer value
        var stats: [Int: Int] = [:]

        for fishTimer in fishTimers {
            stats[fishTimer, default: 0] += 1
        }
        for _ in 1...256 {
            var updatedStats: [Int: Int] = [:]

            updatedStats[6] = stats[0]
            updatedStats[8] = stats[0]
            for timer in 1...8 {
                let newTimer = timer.decremented
                updatedStats[newTimer, default: 0] += stats[timer, default: 0]
            }
            stats = updatedStats
        }
        let result = stats.rawValues.reduce(0, +)

        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 7 - part 1
    func crabSubmarinePosition(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }
        let positions = lines[0].split(",").compactMap { $0.decimal }

        guard let min = positions.min, let max = positions.max else {
            Logger.e(self.logTag, "Could not determine min or max value from array")
            return
        }

        // map contains cost of moving per position
        var costs: [Int: Int] = [:]
        for level in min...max {
            costs[level] = 0
            for position in positions {
                costs[level, default: 0] += abs(level - position)
            }
        }

        Logger.v(self.logTag, "Result: \(costs.rawValues.min.readable)")
    }

    // MARK: Day 7 - part 2
    func crabSubmarinePositionIncremental(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }
        let positions = lines[0].split(",").compactMap { $0.decimal }

        guard let min = positions.min, let max = positions.max else {
            Logger.e(self.logTag, "Could not determine min or max value from array")
            return
        }

        var costCache: [Int: Int] = [:]
        func calculateCost(_ from: Int, _ to: Int) -> Int {
            guard from != to else {
                return 0
            }
            let distance = abs(from - to)
            if let cost = costCache[distance] {
                return cost
            }
            var cost = 0
            for step in 0..<distance {
                cost += step + 1
                costCache[step + 1] = cost
            }
            return cost
        }
        // map contains cost of moving per position
        var costs: [Int: Int] = [:]
        for level in min...max {
            costs[level] = 0
            for position in positions {
                costs[level, default: 0] += calculateCost(level, position)
            }
        }

        Logger.v(self.logTag, "Result: \(costs.rawValues.min.readable)")
    }

    // MARK: Day 8 - part 1
    func sevenSegmentSearch(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        let lengths = [2, 4, 3, 7]
        var result = 0
        for line in lines {
            let parts = line.split("|")
            let digitList = parts[1].trimming(" ")
            for digit in digitList.split(" ") {
                if lengths.contains(digit.count) {
                    result.increment()
                }
            }
        }
        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 8 - part 1
    func sevenSegmentFullSearch(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }
        let input = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |cdfeb fcadb cdfeb cdbaf"
        // mapping lenght to possible digit

        var result = 0

        for input in lines {
            // map of mixed segment to real one
            var segmentMapping: [String: String] = [:]
            var digit2mixedSegment: [Int: String] = [:]

            let parts = input.split("|")
            let patterns = parts[0].trimming(" ").split(" ").map { $0.sorted }
            for pattern in patterns {
                switch pattern.count {
                case 2:
                    digit2mixedSegment[1] = pattern
                case 3:
                    digit2mixedSegment[7] = pattern
                case 4:
                    digit2mixedSegment[4] = pattern
                case 7:
                    digit2mixedSegment[8] = pattern
                default:
                    break
                }
            }
            segmentMapping["a"] = digit2mixedSegment[7] - digit2mixedSegment[1]
            digit2mixedSegment[9] = patterns.filter{ $0.count == 6 }.first{ ($0 - digit2mixedSegment[4]).count == 2 }
            segmentMapping["e"] = digit2mixedSegment[8] - digit2mixedSegment[9]
            segmentMapping["g"] = digit2mixedSegment[9] - digit2mixedSegment[4] - segmentMapping["a"]
            digit2mixedSegment[3] = patterns.filter{ $0.count == 5 }.first {
                ($0 - (digit2mixedSegment[7] + segmentMapping["g"])).count == 1
            }
            segmentMapping["b"] = digit2mixedSegment[4] - digit2mixedSegment[3]
            segmentMapping["d"] = digit2mixedSegment[4] - digit2mixedSegment[1] - segmentMapping["b"]
            digit2mixedSegment[0] = digit2mixedSegment[8] - segmentMapping["d"]
            var sixSegments = patterns.filter{ $0.count == 6 }
            sixSegments.remove(object: digit2mixedSegment[0])
            sixSegments.remove(object: digit2mixedSegment[9])
            digit2mixedSegment[6] = sixSegments.first
            segmentMapping["c"] = digit2mixedSegment[3] - digit2mixedSegment[6]
            digit2mixedSegment[2] = "acdeg".array.compactMap{ segmentMapping[$0] }.reduce("", +).sorted
            segmentMapping["f"] = digit2mixedSegment[3] - digit2mixedSegment[2]
            digit2mixedSegment[5] = "abdfg".array.compactMap{ segmentMapping[$0] }.reduce("", +).sorted

//            print(digit2mixedSegment)
//            print(segmentMapping)

            let digits = parts[1]
                .trimming(" ")
                .split(" ")
                .map { $0.sorted }
                .compactMap{ digit in
                    digit2mixedSegment.first{ $0.value == digit }?.key
                }
            if let number = (digits.map { "\($0)" }.joined().decimal) {
                result += number
            }
        }
        Logger.v(self.logTag, "Result: \(result)")
    }
}

//
//  Solution2021.swift
//
//
//  Created by Tomasz on 29/11/2022.
//

// group folding: Shift + option + command + left/right arrow

import Foundation

class Solution2021 {
    private let logTag = "Solution2021"

    // MARK: Day 1 - part 1
    func amountOfIncreasedNumber(input: String) -> Int {
        let numbers = input.split("\n")
            .filter { !$0.isEmpty }
            .compactMap { $0.decimal }

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
        return result
    }

    // MARK: Day 1 - part 2
    func amountOfIncreasedNumbersWindowed(input: String) -> Int {
        let numbers = input.split("\n")
            .filter { !$0.isEmpty }
            .compactMap { $0.decimal }

        let windowedNumbers = numbers
            .windowed(by: 3)
            .map { $0.reduce(0, +) }

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
        return result
    }

    // MARK: Day 2 - part 1
    func travelling2dMap(input: String) -> Int {
        let lines = input.split("\n")
        var x = 0
        var y = 0

        for line in lines {
            let parts = line.split(" ")
            guard let command = parts[safeIndex: 0],
                  let value = parts[safeIndex: 1]?.decimal else {
                continue
            }
            switch command {
            case "forward":
                x += value
            case "down":
                y += value
            case "up":
                y -= value
            default:
                Logger.e(self.logTag, "Invalid command \(command)")
            }
        }
        let result = x * y
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }

    // MARK: Day 2 - part 2
    func travelling2dMap2(input: String) -> Int {
        let lines = input.split("\n").filter { !$0.isEmpty }
        var x = 0
        var y = 0
        var aim = 0

        for line in lines {
            let parts = line.split(" ")
            guard let command = parts[safeIndex: 0],
                  let value = parts[safeIndex: 1]?.decimal else {
                continue
            }
            switch command {
            case "forward":
                x += value
                y += aim * value
            case "down":
                aim += value
            case "up":
                aim -= value
            default:
                Logger.e(self.logTag, "Invalid command \(command)")
            }
        }
        let result = x * y
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }

    // MARK: Day 3 - part 1
    func mostCommonBitCounter(input: String) -> Int? {
        let lines = input.split("\n").filter { !$0.isEmpty }
        let numberAmount = lines.count
        let half = numberAmount / 2

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

        for index in 0..<oneCounter.keys.count {
            if oneCounter[index, default: 0] > half {
                gammaRate.append("1")
                epsilonRate.append("0")
            } else {
                gammaRate.append("0")
                epsilonRate.append("1")
            }
        }
        let result = (gammaRate.binary ?? 0) * (epsilonRate.binary ?? 0)
        Logger.v(self.logTag, "Result: \(result)")
        return result
    }

    // MARK: Day 3 - part 2
    func bitFiltering(input: String) -> Int {
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
                        oxygens.removeFirst(object: number)
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
                        scrubbers.removeFirst(object: number)
                    }
                }
            }
            position.increment()
        }
        let result = (oxygens.first?.binary ?? 0) * (scrubbers.first?.binary ?? 0)
        Logger.v(self.logTag, "Result: \(result)")
        return result
    }

    // MARK: Day 4 - part 1
    func giantSquidBingo(input: String) {
        let lines = input.split("\n").map { $0.trimming(" ") }
        let numbers = lines[0].split(",").compactMap { $0.decimal }

        let numberOfLines = lines.count

        var currentLine = 2

        var bingoCards: [BingoCard] = []
        while currentLine < numberOfLines.decremented {
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
        while currentLine < numberOfLines.decremented {
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
                    bingoCards.removeFirst(object: bingoCard)
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
            stats[fishTimer, default: 0].increment()
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
            sixSegments.removeFirst(object: digit2mixedSegment[0])
            sixSegments.removeFirst(object: digit2mixedSegment[9])
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

    // MARK: Day 9 - part 1
    func lowestPoint(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var map: [Point: Int] = [:]
        for (y, line) in lines.enumerated() {
            let digits = line.array.compactMap { $0.decimal }
            for (x, number) in digits.enumerated() {
                map[Point(x: x, y: y)] = number
            }
        }

        var lowPoints: [Int] = []
        main: for data in map {
            let point = data.key
            let value = data.value

            for direction in MoveDirection.allCases {
                if let upValue = map[point.move(direction)], upValue <= value {
                    continue main
                }
            }
            lowPoints.append(value + 1)
        }
        Logger.v(self.logTag, "Result: \(lowPoints.reduce(0, +))")
    }

    // MARK: Day 9 - part 2
    func basins(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var map: [Point: Int] = [:]
        for (y, line) in lines.enumerated() {
            let digits = line.array.compactMap { $0.decimal }
            for (x, number) in digits.enumerated() {
                map[Point(x: x, y: y)] = number
            }
        }

        var sizes: [Int] = []

        // start searching basins on map
        for (mapPoint, _) in map {
            var basinPoints: [Point] = []
            var toCheck: [Point] = []

            basinPoints.append(mapPoint)
            toCheck.append(mapPoint)

            loop: while !toCheck.isEmpty {
                let point = toCheck.removeFirst()
                let value = map[point]
                if value == 9 {
                    continue
                }
                // check all neighbours's value
                for neighbourPoint in point.linearNeighbours {
                    let neighbourValue = map[neighbourPoint]
                    if neighbourValue.isNil || neighbourValue == 9 {
                        continue
                    }
                    if value!.incremented == neighbourValue {
                        if !basinPoints.contains(neighbourPoint) {
                            toCheck.append(neighbourPoint)
                            basinPoints.append(neighbourPoint)
                        }
                    }
                }
            }
            sizes.append(basinPoints.count)
        }
        let largest = sizes.max(amount: 3)
        let result = largest.reduce(1, *)
        print(sizes.sorted())
        print(largest)
        print("Points on map: \(map.count) basins: \(sizes.count)")
        // wrong 381570 too low
        // wrong 1052256
        // wrong 529475129
        // wrong 6537520
        // wrong 365976
        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 10 - part 1
    func corruptedCode(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        let definitions = [
            "(": ")",
            "[": "]",
            "{": "}",
            "<": ">",
        ]

        var points = [Int: Int]()
        lines: for line in lines {
            let tokens = line.array
            var lilo = [String]()
            for token in tokens {
                if definitions.rawKeys.contains(token) {
                    // its opening token
                    lilo.append(token)
                } else {
                    // closing token
                    let lastLifo = lilo.removeLast()
                    let expectedClosingToken = definitions[lastLifo]
                    if expectedClosingToken != token {
                        // error
                        Logger.v(self.logTag, "Expected \(expectedClosingToken.readable) but found \(token)")
                        switch token {
                        case ")":
                            points[3, default: 0].increment()
                        case "]":
                            points[57, default: 0].increment()
                        case "}":
                            points[1197, default: 0].increment()
                        case ">":
                            points[25137, default: 0].increment()
                        default:
                            break
                        }
                        continue lines
                    }
                }
            }
        }
        let result = points.map { $0.key * $0.value }.reduce(0, +)
        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 10 - part 2
    func incompleteCode(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        let definitions = [
            "(": ")",
            "[": "]",
            "{": "}",
            "<": ">",
        ]
        let worth = [
            ")": 1,
            "]": 2,
            "}": 3,
            ">": 4,
        ]

        var totalScores = [Int]()
        lines: for line in lines {
            let tokens = line.array
            var lilo = [String]()
            for token in tokens {
                if definitions.rawKeys.contains(token) {
                    // its opening token
                    lilo.append(token)
                } else {
                    // closing token
                    let lastLifo = lilo.removeLast()
                    let expectedClosingToken = definitions[lastLifo]
                    if expectedClosingToken != token {
                        // error
                        continue lines
                    }
                }
            }
            if lilo.count > 0 {
                var score = 0
                while !lilo.isEmpty {
                    let openingToken = lilo.removeLast()
                    let closingToken = definitions[openingToken]
                    score *= 5
                    score += worth[closingToken!]
                }
                totalScores.append(score)
            }
        }
        //3235371166
        let result = totalScores.sorted()[totalScores.count / 2]
        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 11 - part 1
    func flashingNumbers(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var map: [Point: Int] = [:]
        for (y, line) in lines.enumerated() {
            let digits = line.array.compactMap { $0.decimal }
            for (x, number) in digits.enumerated() {
                map[Point(x: x, y: y)] = number
            }
        }

        func flash(_ point: Point) {
            guard map[point] == 10 else { return }
            for neighbour in point.linearNeighbours + point.diagonalNeighbours {
                map[neighbour]?.increment()
                flash(neighbour)
            }
        }
        var flashCounter = 0
        for _ in 1...100 {
            // increase all point's energy level
            for (point, _) in map {
                map[point]?.increment()
                flash(point)
            }

            // reset all flashing poit's energy levels to 0
            for (point, _) in map {
                if map[point] > 9 {
                    map[point] = 0
                    flashCounter.increment()
                }
            }
        }
        Logger.v(self.logTag, "Result: \(flashCounter)")
    }

    // MARK: Day 11 - part 2
    func numbersFlashSimultaneously(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var map: [Point: Int] = [:]
        for (y, line) in lines.enumerated() {
            let digits = line.array.compactMap { $0.decimal }
            for (x, number) in digits.enumerated() {
                map[Point(x: x, y: y)] = number
            }
        }
        let mapSize = map.count

        func flash(_ point: Point) {
            guard map[point] == 10 else { return }
            for neighbour in point.linearNeighbours + point.diagonalNeighbours {
                map[neighbour]?.increment()
                flash(neighbour)
            }
        }

        for iteration in 1...2000 {
            // increase all point's energy level
            for (point, _) in map {
                map[point]?.increment()
                flash(point)
            }

            // reset all flashing poit's energy levels to 0
            var flashCounter = 0
            for (point, _) in map {
                if map[point] > 9 {
                    map[point] = 0
                    flashCounter.increment()
                }
            }
            if flashCounter == mapSize {
                Logger.v(self.logTag, "Result: \(iteration)")
                return
            }
        }
        Logger.v(self.logTag, "No result")
    }

    // MARK: Day 12 - part 1
    func nodeWalking(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var connections: [String: [String]] = [:]
        for line in lines {
            let parts = line.split("-")
            let start = parts[0]
            let end = parts[1]

            connections[start, default: []].append(end)
            connections[end, default: []].append(start)
        }

        var readyPaths: [[String]] = []

        func addNode(path: [String]) {
            guard let lastNode = path.last, lastNode != "end" else {
                readyPaths.append(path)
                return
            }
            for tail in connections[lastNode] ?? [] {
                if tail.lowercased() == tail, path.contains(tail) {
                    continue
                }
                let newPath = path.withAppended(tail)
                addNode(path: newPath)
            }
        }

        addNode(path: ["start"])
        Logger.v(self.logTag, "Result: \(readyPaths.count)")
    }

    // MARK: Day 12 - part 2
    func nodeWalkingTwice(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var connections: [String: [String]] = [:]
        for line in lines {
            let parts = line.split("-")
            let start = parts[0]
            let end = parts[1]

            connections[start, default: []].append(end)
            connections[end, default: []].append(start)
        }

        var readyPaths: [[String]] = []

        func hasTwoSameNodes(path: [String]) -> Bool {
            for body in path {
                if body == "start" || body.uppercased() == body {
                    continue
                }
                if (path.count{ $0 == body }) > 1 {
                    return true
                }
            }
            return false
        }

        func canApend(node: String, to path: [String]) -> Bool {
            if node.uppercased() == node {
                return true
            }
            if node == "start" {
                return false
            }
            if !path.contains(node) {
                return true
            }
            return !hasTwoSameNodes(path: path)
        }

        func addNode(path: [String]) {
            guard let lastNode = path.last, lastNode != "end" else {
                readyPaths.append(path)
                return
            }
            for tail in connections[lastNode] ?? [] {
                if !canApend(node: tail, to: path) {
                    continue
                }
                let newPath = path.withAppended(tail)
                addNode(path: newPath)
            }
        }

        addNode(path: ["start"])
        Logger.v(self.logTag, "Result: \(readyPaths.count)")
    }

    // MARK: Day 13 - part 1
    func foldingPaper(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var dots: [Point: Bool] = [:]
        var instructions: [(side: String, index: Int)] = []

        for line in lines {
            if line.starts(with: "fold") {
                let parts = line.split(" ")
                let data = parts[2].split("=")
                instructions.append((data[0], data[1].decimal!))
            } else {
                let parts = line.split(",")
                let x = parts[0].decimal
                let y = parts[1].decimal
                dots[Point(x: x!, y: y!)] = true
            }
        }

        let maxX = dots.map{ $0.key.x }.max!
        let maxY = dots.map{ $0.key.y }.max!
        func printDots() {
            var output = "\n"
            for y in 0...maxY {
                for x in 0...maxX {
                    dots[Point(x: x, y: y)].isNil ? output.append(".") : output.append("#")
                }
                output.append("\n")
            }
            output.append("\n")
            print(output)
        }
        //printDots()
        if let instruction = instructions.first {
            switch instruction.side {
            case "x":
                // fold left
                let foldLine = instruction.index + 1
                var distance = -1
                for x in foldLine...maxX {
                    for y in 0...maxY {
                        if dots[Point(x: x, y: y)] == true {
                            dots[Point(x: x, y: y)] = nil
                            dots[Point(x: x + distance * 2, y: y)] = true
                        }
                    }
                    distance.decrement()
                }
            case "y":
                // fold up
                let foldLine = instruction.index + 1
                var distance = -1
                for y in foldLine...maxY {
                    for x in 0...maxX {
                        if dots[Point(x: x, y: y)] == true {
                            dots[Point(x: x, y: y)] = nil
                            dots[Point(x: x, y: y + distance * 2)] = true
                        }
                    }
                    distance.decrement()
                }
            default:
                break
            }
        }
        //printDots()
        let result = dots.map{ $0.value }.filter{ $0 }.count
        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 13 - part 2
    func foldingPaperMultipleTimes(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var dots: [Point: Bool] = [:]
        var instructions: [(side: String, index: Int)] = []
        for line in lines {
            if line.starts(with: "fold") {
                let parts = line.split(" ")
                let data = parts[2].split("=")
                instructions.append((data[0], data[1].decimal!))
            } else {
                let parts = line.split(",")
                let x = parts[0].decimal
                let y = parts[1].decimal
                dots[Point(x: x!, y: y!)] = true
            }
        }

        func printDots() {
            var output = "\n"
            let maxX = dots.map{ $0.key.x }.max!
            let maxY = dots.map{ $0.key.y }.max!
            for y in 0...maxY {
                for x in 0...maxX {
                    dots[Point(x: x, y: y)].isNil ? output.append(".") : output.append("#")
                }
                output.append("\n")
            }
            output.append("\n")
            print(output)
        }
//        printDots()
        while !instructions.isEmpty {
            let instruction = instructions.removeFirst()
            let maxX = dots.map{ $0.key.x }.max!
            let maxY = dots.map{ $0.key.y }.max!
            switch instruction.side {
            case "x":
                // fold left
                let foldLine = instruction.index + 1
                var distance = -1
                for x in foldLine...maxX {
                    for y in 0...maxY {
                        if dots[Point(x: x, y: y)] == true {
                            dots[Point(x: x, y: y)] = nil
                            dots[Point(x: x + distance * 2, y: y)] = true
                        }
                    }
                    distance.decrement()
                }
            case "y":
                // fold up
                let foldLine = instruction.index + 1
                var distance = -1
                for y in foldLine...maxY {
                    for x in 0...maxX {
                        if dots[Point(x: x, y: y)] == true {
                            dots[Point(x: x, y: y)] = nil
                            dots[Point(x: x, y: y + distance * 2)] = true
                        }
                    }
                    distance.decrement()
                }
            default:
                break
            }
        }
        printDots()
        let result = dots.map{ $0.value }.filter{ $0 }.count
        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 14 - part 1
    func chemicalFormuae(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var replacement: [String: String] = [:]
        var formula = lines[0]
        for line in lines[1...] {
            let parts = line.split(" -> ")
            replacement[parts[0]] = parts[1]
        }

        for _ in 1...10 {
            var cut: [String] = []
            for index in 0..<formula.count.decremented {
                let elem = formula.subString(index, index + 2)
                if let glue = replacement[elem] {
                    cut.append("\(elem[0])\(glue)")
                } else {
                    cut.append(elem[0])
                }
            }
            cut.append(formula.last)
            formula = cut.joined()
        }
        let elems = formula.array.unique
        var stats: [Int] = []
        for elem in elems {
            stats += formula.array.count{ $0 == elem }
        }
        let result = stats.max! - stats.min!
        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 14 - part 2
    func chemicalFormuaeLong(input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var replacement: [String: String] = [:]
        let formula = lines[0]
        for line in lines[1...] {
            let parts = line.split(" -> ")
            replacement[parts[0]] = parts[1]
        }

        var pairStats: [String: Int] = [:]
        for index in 0..<formula.count.decremented {
            let elem = formula.subString(index, index + 2)
            pairStats[elem, default: 0].increment()
        }
        let steps = 40
        for _ in 1..<steps {
            var newStats: [String: Int] = [:]
            for (elem, amount) in pairStats {
                if let glue = replacement[elem] {
                    let pair1 = elem[0].string + glue
                    let pair2 = glue + elem[1].string
                    newStats[pair1, default: 0] += amount
                    newStats[pair2, default: 0] += amount
//                    print("Pair \(elem) will be replaced to \(pair1) and \(pair2)")
                } else {
                    newStats[elem] = amount
                }
            }
            pairStats = newStats
        }
        // gather final stats dropping overlapping letters
        var newStats: [String: Int] = [:]
        for (elem, amount) in pairStats {
            if let glue = replacement[elem] {
                let pair1 = elem[0].string + glue
                newStats[pair1, default: 0] += amount
            } else {
                newStats[elem] = amount
            }
        }
        pairStats = newStats
        var stats: [String: Int] = [:]
        for (pair, amount) in pairStats {
            stats[pair[0].string, default: 0] += amount
            stats[pair[1].string, default: 0] += amount
        }
        stats[formula.last!.string, default: 0].increment()
        let result = stats.rawValues.max! - stats.rawValues.min!
        Logger.v(self.logTag, "Result: \(result)")
    }

    // MARK: Day 15 - part 1
    func shortestWay(input: String) -> Int? {
        let lines = input.split("\n")
            .filter{ !$0.isEmpty }
            .map { $0.trimming(" ") }

        var riskMap: [Point: Int] = [:]
        let size = lines[0].count - 1

        let navi = AdjacencyList<Point>()
        for (y, line) in lines.enumerated() {
            for (x, risk) in line.array.enumerated() {
                let point = Point(x: x, y: y)
                riskMap[point] = risk.decimal
            }
        }
        for point in riskMap.rawKeys {
            for direction in MoveDirection.allCases {
                let destination = point.move(direction)
                if let risk = riskMap[destination] {
                    navi.add(.directed, from: navi.createVertex(data: point), to: navi.createVertex(data: destination), weight: risk)
                }
            }
        }
        let start = navi.createVertex(data: Point(x: 0, y: 0))
        let end = navi.createVertex(data: Point(x: size, y: size))
        let edges = navi.dijkstra(from: start, to: end)

        let result = edges?.map{ riskMap[$0.destination.data] }.reduce(0, +)
//        edges?.forEach{ print("\($0.destination.data) \(riskMap[$0.destination.data].readable)" ) }
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 15 - part 1
    func shortestWayBiggerMap(input: String) -> Int? {
        let lines = input.split("\n")
            .filter{ !$0.isEmpty }
            .map { $0.trimming(" ") }

        var riskMap: [Point: Int] = [:]
        let size = lines[0].count

        let navi = AdjacencyList<Point>()
        for (y, line) in lines.enumerated() {
            for (x, risk) in line.array.enumerated() {
                let point = Point(x: x, y: y)
                riskMap[point] = risk.decimal
            }
        }
        print("size = \(riskMap.count)")
        func next(_ risk: Int?) -> Int? {
            let nextRisk = risk?.incremented
            if nextRisk > 9 {
                return 1
            }
            return nextRisk
        }

        for segment in 0..<4 {
            for y in 0..<size {
                for x in 0..<size {
                    let offset = segment * size
                    let sourcePoint = Point(x: x + offset, y: y)
                    let destinationPoint = Point(x: x + size + offset, y: y)
                    let destinationValue = next(riskMap[sourcePoint])
                    riskMap[destinationPoint] = destinationValue
                }
            }
        }

        for s in 0...4 {
            for segment in 0..<4 {
                for y in 0..<size {
                    for x in 0..<size {
                        let offset = segment * size
                        let sourcePoint = Point(x: x + s * size, y: y + offset)
                        let destinationPoint = Point(x: x + s * size, y: y + size + offset)
                        let destinationValue = next(riskMap[sourcePoint])
                        riskMap[destinationPoint] = destinationValue
                    }
                }
            }
        }

        print("size = \(riskMap.count)")
//        for y in 0..<100 {
//            var row: [Int] = []
//            for x in 0..<100 {
//                row.append(riskMap[Point(x: x, y: y)])
//            }
//            let line = row.chunked(by: 10).map{ $0.map{ "\($0)"}.joined()}
//                .joined(separator: " ")
//            print("line: \(line)")
//            if (y + 1)  % 10 == 0, y > 1 {
//                print(" ")
//            }
//        }

        let directions: [MoveDirection] = [.down, .right]
        for point in riskMap.rawKeys {
            for direction in directions {
                let destination = point.move(direction)
                if let risk = riskMap[destination] {
                    navi.add(.directed, from: navi.createVertex(data: point), to: navi.createVertex(data: destination), weight: risk)
                }
            }
        }
        let start = navi.createVertex(data: Point(x: 0, y: 0))
        let end = navi.createVertex(data: Point(x: riskMap.rawKeys.map{ $0.x }.max!, y: riskMap.rawKeys.map{ $0.y }.max!))
        let edges = navi.dijkstra(from: start, to: end)

        let result = edges?.map{ riskMap[$0.destination.data] }.reduce(0, +)
//        edges?.forEach{ print("\($0.destination.data) \(riskMap[$0.destination.data].readable)" ) }
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 16 - part 1
    func day16(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        let hexCode = lines[0]
        var binaryCode = ""
        for hex in hexCode.array {
            binaryCode.append(hex.hex?.binary)
        }

        let packetVersion = binaryCode.subString(0, 3).binary
        let typeID = binaryCode.subString(3, 5).decimal
        binaryCode.removeFirst(6)

        let result: Int? = 0
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }
}

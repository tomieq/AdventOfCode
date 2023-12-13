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
    
    // MARK: Day 7 - part 1
    func camelCards(input: String) -> Int {
        let lines = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
        struct Hand: CustomStringConvertible {
            let cards: String
            let bet: Int
            
            var description: String {
                "cards: \(cards) bet: \(bet)"
            }
        }
        let cardPowerOrder = "AKQJT98765432".array
        var cardPowerMap: [String: Int] = [:]
        cardPowerOrder.reversed().enumerated().forEach {
            cardPowerMap[$0.element] = $0.offset
        }
        var hands = lines.map {
            let data = $0.split(" ").tuple
            return Hand(cards: data.0, bet: data.1.decimal!)
        }

        hands.sort { p, n in
            let pStats = p.cards.letterStatistics.rawValues.sorted().reversed.filled(with: 0, toSize: 5)
            let nStats = n.cards.letterStatistics.rawValues.sorted().reversed.filled(with: 0, toSize: 5)
//            print("cards: \(p.cards) stats: \(pStats)")
//            print("cards: \(n.cards) stats: \(nStats)")
            if pStats == nStats {
                let pPowers = p.cards.array.map { cardPowerMap[$0]! }
                let nPowers = n.cards.array.map { cardPowerMap[$0]! }
//                print("p cards: \(p.cards) stats: \(pPowers)")
//                print("n cards: \(n.cards) stats: \(nPowers)")
                return pPowers < nPowers
            }
            return pStats < nStats
        }
        print(hands)
        
        let result = hands.enumerated().map{ ($0.offset + 1) * $0.element.bet }.reduce(0, +)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 7 - part 2
    func camelCards2(input: String) -> Int {
        let lines = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
        struct Hand: CustomStringConvertible {
            let cards: String
            let bet: Int
            
            var description: String {
                "cards: \(cards) bet: \(bet)"
            }
        }
        let order = "AKQT98765432J".array
        var power: [String: Int] = [:]
        order.reversed().enumerated().forEach {
            power[$0.element] = $0.offset
        }
        var hands = lines.map {
            let data = $0.split(" ").tuple
            return Hand(cards: data.0, bet: data.1.decimal!)
        }

        hands.sort { p, n in
            let pJokers = p.cards.array.count { $0 == "J" }
            let nJokers = n.cards.array.count { $0 == "J" }
            var pStats = p.cards.removed(text: "J").letterStatistics.rawValues.sorted().reversed.filled(with: 0, toSize: 5)
            var nStats = n.cards.removed(text: "J").letterStatistics.rawValues.sorted().reversed.filled(with: 0, toSize: 5)
            pStats[0] += pJokers
            nStats[0] += nJokers
//            print("cards: \(p.cards) stats: \(pStats)")
//            print("cards: \(n.cards) stats: \(nStats)")
            if pStats == nStats {
                let pPowers = p.cards.array.map { power[$0]! }
                let nPowers = n.cards.array.map { power[$0]! }
//                print("p cards: \(p.cards) stats: \(pPowers)")
//                print("n cards: \(n.cards) stats: \(nPowers)")
                return pPowers < nPowers
            }
            return pStats < nStats
        }
        print(hands)
        
        let result = hands.enumerated().map{ ($0.offset + 1) * $0.element.bet }.reduce(0, +)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 8 - part 1
    func crawlInstructions(input: String) -> Int {
        
        let ins = CircularVector(input.split("\n").first!.trimmed.array)
//        print(ins)
        var map: [String:[String:String]] = [:]
        input.split("\n")
            .removedFirst(amount: 1)
            .filter { !$0.isEmpty }
            .forEach {
                let parts = $0.split(" = ")
                let source = parts[0]
                let (left, right) = parts[1].trimming("()").split(", ").tuple
                map[source] = ["L": left, "R": right]
            }
        var result = 0
        var node = "AAA"
        while node != "ZZZ" {
            result.increment()
            node = map[node]![ins.next]!
        }
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 8 - part 2
    func crawlInstructions2(input: String) -> Int {
        let initialInstructions = input.split("\n").first!.trimmed.array
        
        var map: [String:[String:String]] = [:]
        input.split("\n")
            .removedFirst(amount: 1)
            .filter { !$0.isEmpty }
            .forEach {
                let parts = $0.split(" = ")
                let source = parts[0]
                let (left, right) = parts[1].trimming("()").split(", ").tuple
                map[source] = ["L": left, "R": right]
            }
        let startingPoints = map.rawKeys.filter{ $0[2] == "A" }
        
        func countSteps(start: String) -> Int {
            var point = start
            var steps = 0
            let ins = CircularVector(initialInstructions)
            while point[2] != "Z" {
                point = map[point]![ins.next]!
                steps.increment()
            }
            return steps
        }
        var steps = startingPoints.map { countSteps(start: $0) }
        print(steps)
        
        while steps.count > 1 {
            steps = [steps[0].leastCommonMultiple(with: steps[1])] + steps.removedFirst(amount: 2)
        }
        let result = steps[0]
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 9 - part 1
    func numberSequence(input: String) -> Int {
        
        func getDelta(_ input: [Int]) -> [Int] {
            input.enumerated().compactMap { index, value in
                guard let nextValue = input[safeIndex: index + 1] else {
                    return nil
                }
                return nextValue - value
            }
        }
        func isZeroed(_ input: [Int]) -> Bool {
            input.count == input.count { $0 == 0 }
        }

        let result = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed.split(" ").compactMap{ $0.decimal } }
            .map {
                var container: [[Int]] = [$0]
                while !isZeroed(container.last!) {
                    container.append(getDelta(container.last!))
                }
                return container
            }
            .compactMap { line in
                var rev = line.reversed
                for (index, array) in rev.enumerated() {
                    rev[index].append(rev[safeIndex: index - 1]?.last + array.last)
                }
                return rev.last
            }.compactMap {
                $0.last
            }.reduce(0, +)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }

    // MARK: Day 9 - part 2
    func numberSequence2(input: String) -> Int {

        func getDelta(_ input: [Int]) -> [Int] {
            input.enumerated().compactMap { index, value in
                guard let nextValue = input[safeIndex: index + 1] else {
                    return nil
                }
                return nextValue - value
            }
        }
        func isZeroed(_ input: [Int]) -> Bool {
            input.count == input.count { $0 == 0 }
        }

        let result = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed.split(" ").compactMap{ $0.decimal } }
            .map {
                var container: [[Int]] = [$0]
                while !isZeroed(container.last!) {
                    container.append(getDelta(container.last!))
                }
                return container
            }
            .compactMap { line in
                var rev = line.reversed
                for (index, array) in rev.enumerated() {
                    rev[index].prepend(array.first! - rev[safeIndex: index - 1]?.first)
                }
                return rev.last
            }.compactMap {
                $0.first
            }.reduce(0, +)

        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    
    // MARK: Day 10 - part 1
    func crawlingPipes(input: String) -> Int {
        
        let directionMapping: [String: [MoveDirection]] = [
            "|": [.up, .down],
            "L": [.up, .right],
            "-": [.right, .left],
            "J": [.left, .up],
            "7": [.left, .down],
            "F": [.right, .down],
            "S": MoveDirection.allCases
        ]
        let coords = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
            .enumerated()
            .flatMap { i, v in
                v.array.enumerated()
                    .filter{ $0.element != "." }
                    .map { (Point(x: $0.offset, y: i), $0.element) }
            }
        let start = coords.first { $0.1 == "S" }!.0
        let pipes = coords.compactMap { TupleZip.make($0.0, directionMapping[$0.1]) }
            .reduce(into: [:]) { $0[$1.0] = $1.1 }

        func nextPoints(_ way: [Point]) -> [Point] {
            let point = way.last!
            return pipes[point]?
                .map { (point.move($0), $0) }
                .filter { way.contains($0.0).not }
                .filter { pipes[$0.0]?.contains($0.1.other) ?? false }
                .map { $0.0 } ?? []
        }
        func move2Next(_ way: inout [Point]) {
            let next = nextPoints(way).first
            way.removeFirst()
            way.append(next)
        }
        var ways = nextPoints([start]).map{ [start, $0] }.tuple
        var stepCounter = 1
        while ways.0.contains(ways.1.last!).not {
            move2Next(&ways.0)
            move2Next(&ways.1)
            stepCounter.increment()
        }

        let result = stepCounter
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    // MARK: Day 11 - part 1
    func spaceShortestWay(input: String) -> Int {

        let galaxies = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
            .enumerated()
            .flatMap { i, v in
                v.array.enumerated()
                    .filter{ $0.element != "." }
                    .map { Point(x: $0.offset, y: i) }
            }

        let width = galaxies.map { $0.x }.max
        let height = galaxies.map { $0.y }.max
        let emptyRows = (0...height).filter{ y in galaxies.filter{ $0.y ==  y}.isEmpty }
        let emptyColumns = (0...width).filter{ x in galaxies.filter{ $0.x ==  x}.isEmpty }
        var expanded = galaxies
        emptyColumns.reversed.forEach { x in
            expanded = expanded.map {
                $0.x > x ? $0.move(.right) : $0
            }
        }
        emptyRows.reversed.forEach { y in
            expanded = expanded.map {
                $0.y > y ? $0.move(.down) : $0
            }
        }
        let result = expanded
            .combinations(ofCount: 2)
            .map {
                let start = $0[0]
                let end = $0[1]
                return abs(end.x - start.x) + abs(end.y - start.y)
            }.reduce(0, +)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 11 - part 2
    func spaceShortestWay2(input: String) -> Int {

        let galaxies = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
            .enumerated()
            .flatMap { i, v in
                v.array.enumerated()
                    .filter{ $0.element != "." }
                    .map { Point(x: $0.offset, y: i) }
            }
        let width = galaxies.map { $0.x }.max
        let height = galaxies.map { $0.y }.max

        let emptyRows = (0...height).filter{ y in galaxies.filter{ $0.y ==  y}.isEmpty }
        let emptyColumns = (0...width).filter{ x in galaxies.filter{ $0.x ==  x}.isEmpty }
        var expanded = galaxies
        emptyColumns.reversed.forEach { x in
            expanded = expanded.map {
                $0.x > x ? Point(x: $0.x + 1000000.decremented, y: $0.y) : $0
            }
        }
        emptyRows.reversed.forEach { y in
            expanded = expanded.map {
                $0.y > y ? Point(x: $0.x, y: $0.y + 1000000.decremented) : $0
            }
        }
        let result = expanded
            .combinations(ofCount: 2)
            .map {
                let start = $0[0]
                let end = $0[1]
                return abs(end.x - start.x) + abs(end.y - start.y)
            }.reduce(0, +)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 12 - part 1
    func discoverArrangements(input: String) -> Int {

        func hasCombinations(record: String, stat: Int) -> Bool {
            if record.contains("?").not, record.count == stat {
                return false
            }
            if (stat...stat + 1).contains(record.count), record.contains("#") {
                return false
            }
            return true
        }
        
        func getCombinations(_ record: String) -> [String] {
            if record.contains("?") {
                return getCombinations(record.replaced(onlyFirst: "?", with: ".")) + getCombinations(record.replaced(onlyFirst: "?", with: "#"))
            }
            return [record]
        }
        
        func calculateStats(_ record: String) -> [Int] {
            var result: [Int] = []
            var partialResult = 0
            for letter in record {
                if letter == "#" {
                    partialResult.increment()
                } else if partialResult > 0 {
                    result.append(partialResult)
                    partialResult = 0
                }
            }
            if partialResult > 0 {
                result.append(partialResult)
            }
            return result
        }

        let rows: [(String, [Int])] = input.split("\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmed }
            .map { $0.split(" ").tuple }
            .map {
                // remove multiple dots
                let records = $0.0.split(".")
                    .filter { !$0.isEmpty}
                // map to [Int]
                let stats = $0.1.split(",").compactMap { $0.decimal }
                return (records, stats)
            }
            .map {
                // remove known groups
                var records = $0.0
                var stats = $0.1
                while let record = records.first, let stat = stats.first, !hasCombinations(record: record, stat: stat) {
                    print("Removed \(record) with value: \(stat)")
                    records.removeFirst()
                    stats.removeFirst()
                }
                while let record = records.last, let stat = stats.last, !hasCombinations(record: record, stat: stat) {
                    print("Removed \(record) with value: \(stat)")
                    records.removeLast()
                    stats.removeLast()
                }
                return (records, stats)
            }
            .map {
                ($0.0.joined(separator: "."), $0.1)
            }
        
        let combinationAmounts = rows.map { record, stats in
                guard stats.isEmpty.not else { return 1 }
                return getCombinations(record).count { calculateStats($0) == stats }
            }
        let result = combinationAmounts.reduce(0, +)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 13 - part 1
    func mirrorDetecting(input: String) -> Int {

        let groups = input.split("\n\n")

        func findMirror<T: Equatable>(_ array: [T]) -> Int? {
            guard array.count > 1 else { return nil }
            for i in 0..<array.count.decremented {
                let left = array.subArray(0...i)
                let right = array.subArray(i.incremented...min(i + left.count, array.count.decremented))
                if left.last(amount: right.count) == right.reversed {
                    return i.incremented
                }
            }
            return nil
        }
        
        let result = groups
            .map {
                let rows = $0.split("\n").filter { $0.isEmpty.not}
                let columns = rows[0].enumerated().map { index, _ in
                    rows.map { $0[index].string }.joined()
                }
                if let columnMirror = findMirror(columns) {
                    return columnMirror
                }
                if let rowMirror = findMirror(rows) {
                    return rowMirror * 100
                }
                print(rows, columns)
                fatalError()
            }.reduce(0, +)

        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
    
    // MARK: Day 13 - part 2
    func mirrorDetecting2(input: String) -> Int {

        let groups = input.split("\n\n")

        func findMirrors(_ array: [String]) -> [Int] {
            var mirrors: [Int] = []
            guard array.count > 1 else { return [] }
            for i in 0..<array.count.decremented {
                let left = array.subArray(0...i)
                let right = array.subArray(i.incremented...min(i + left.count, array.count.decremented))
                if left.last(amount: right.count) == right.reversed {
                    mirrors.append(i.incremented)
                }
            }
            return mirrors
        }

        func other(_ letter: String) -> String {
            if letter == "#" { return "." }
            return "#"
        }

        func smudgeVariations(_ array: [String]) -> [[String]] {
            var result: [[String]] = []
            for (rowIndex, row) in array.enumerated() {
                for letterIndex in 0..<row.count {
                    var modifiedRows = array
                    var modifiedValue = modifiedRows[rowIndex].array
                    modifiedValue[letterIndex] = other(modifiedValue[letterIndex])
                    modifiedRows[rowIndex] = modifiedValue.joined()
                    result.append(modifiedRows)
                }
            }
            return result
        }

        typealias Datatype = [(rows: [String], cols: [String], rowMirror: Int?, colMirror: Int?)]
        let data: Datatype = groups
            .map {
                let rows = $0.split("\n").filter { $0.isEmpty.not}
                let columns = rows[0].enumerated().map { index, _ in
                    rows.map { $0[index].string }.joined()
                }
                if let columnMirror = findMirrors(columns).first {
                    return (rows, columns, nil, columnMirror)
                }
                if let rowMirror = findMirrors(rows).first {
                    return (rows, columns, rowMirror, nil)
                }
                print(rows, columns)
                fatalError()
            }

        let result = data.map {
            let rowVariations = smudgeVariations($0.rows)
            for variant in rowVariations {
                var mirrors = findMirrors(variant)
                mirrors.removeFirst(object: $0.rowMirror)
                if mirrors.isEmpty.not {
                    return mirrors.first! * 100
                }
            }
            let colVariations = smudgeVariations($0.cols)
            for variant in colVariations {
                var mirrors = findMirrors(variant)
                mirrors.removeFirst(object: $0.colMirror)
                if mirrors.isEmpty.not {
                    return mirrors.first!
                }
            }
            fatalError()
        }.reduce(0, +)
        Logger.v(self.logTag, "Result = \(result)")
        return result
    }
}

//
//  Solution2022.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

// group folding: Shift + option + command + left/right arrow
import Foundation

class Solution2022 {
    private let logTag = "Solution2022"

    // MARK: Day 1 - part 1
    func maxSumOfGroup(input: String) -> Int? {
        let lines = input.split("\n").map { $0.trimming(" ") }

        var sums: [Int] = []
        var currentSum: Int = 0
        for line in lines {
            if line.isEmpty {
                sums.append(currentSum)
                currentSum = 0
                continue
            }
            currentSum += line.decimal
        }
        let result = sums.max
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 1 - part 2
    func top3MaxSumOfGroup(input: String) -> Int? {
        let lines = input.split("\n").map { $0.trimming(" ") }
        var sums: [Int] = []
        var currentSum: Int = 0
        for line in lines {
            if line.isEmpty {
                sums.append(currentSum)
                currentSum = 0
                continue
            }
            currentSum += line.decimal
        }
        let result = sums.max(amount: 3).reduce(0, +)
        Logger.v(self.logTag, "Result: \(result)")
        return result
    }

    // MARK: Day 2 - part 1
    func paperGameScore(input: String) -> Int {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        let mapping: [String: PaperGame] = [
            "X": .rock, "Y": .paper, "Z": .scissors,
            "A": .rock, "B": .paper, "C": .scissors,
        ]

        var totalScore = 0
        for line in lines {
            let parts = line.split(" ")
            let opponent = mapping[parts[0]]
            let me = mapping[parts[1]]
            var score = 0
            var gameResult: PaperGameResult?
            switch (opponent, me) {
            case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
                gameResult = .lost
            case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
                gameResult = .draw
            default:
                gameResult = .win
            }
            score += gameResult?.rawValue
            score += me?.rawValue
            totalScore += score
        }
        Logger.v(self.logTag, "Result: \(totalScore)")
        return totalScore
    }

    // MARK: Day 2 - part 2
    func paperGameCommand(input: String) -> Int {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        enum Command: String {
            case needWin = "Z"
            case needLose = "X"
            case needDraw = "Y"
        }

        let mapping: [String: PaperGame] = [
            "A": .rock, "B": .paper, "C": .scissors,
        ]

        var totalScore = 0
        for line in lines {
            let parts = line.split(" ")
            let opponent = mapping[parts[0]]
            let command = Command(rawValue: parts[1])

            var gameResult: PaperGameResult?
            var me: PaperGame?
            switch (opponent, command) {
            case (.rock, .needWin):
                me = .paper
                gameResult = .win
            case (.rock, .needLose):
                me = .scissors
                gameResult = .lost
            case (_, .needDraw):
                me = opponent
                gameResult = .draw
            case (.paper, .needWin):
                me = .scissors
                gameResult = .win
            case (.paper, .needLose):
                me = .rock
                gameResult = .lost
            case (.scissors, .needWin):
                me = .rock
                gameResult = .win
            case (.scissors, .needLose):
                me = .paper
                gameResult = .lost
            default:
                break
            }

            totalScore += gameResult?.rawValue
            totalScore += me?.rawValue
        }
        Logger.v(self.logTag, "Result: \(totalScore)")
        return totalScore
    }

    // MARK: Day 3 - part 1
    func arrayCommonLetters1(input: String) -> Int {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var score: [Int] = []
        for line in lines {
            let pack = line.cut(into: 2)
            let common = pack[0].commonLetters(with: pack[1])
            let value = common.ascii
            switch value {
            case 97...122:
                score += value - 96
            case 65...90:
                score += value - 38
            default:
                break
            }
        }

        let result = score.reduce(0, +)
        Logger.v(self.logTag, "Result: \(result)")
        return result
    }

    // MARK: Day 3 - part 2
    func arrayCommonLetters2(input: String) -> Int {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var score: [Int] = []
        let groups = lines.chunked(by: 3)
        for group in groups {
            let common = group[0]
                .commonLetters(with: group[1])
                .commonLetters(with: group[2])
            let value = common.ascii
            switch value {
            case 97...122:
                score += value - 96
            case 65...90:
                score += value - 38
            default:
                break
            }
        }

        let result = score.reduce(0, +)
        Logger.v(self.logTag, "Result: \(result)")
        return result
    }

    // MARK: Day 4 - part 1
    func containingRanges(input: String) -> Int {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var counter = 0
        for line in lines {
            let part = line.split(",")

            let left = part[0].split("-").map{ $0.decimal! }
            let leftRange = Array(left[0]...left[1])

            let right = part[1].split("-").map{ $0.decimal! }
            let rightRange = Array(right[0]...right[1])

            if (leftRange - rightRange).isEmpty || (rightRange - leftRange).isEmpty {
                counter.increment()
            }
        }

        Logger.v(self.logTag, "Result: \(counter)")
        return counter
    }

    // MARK: Day 4 - part 2
    func overlappingRanges(input: String) -> Int {
        let lines = input.split("\n").filter{ !$0.isEmpty }.map { $0.trimming(" ") }

        var counter = 0
        for line in lines {
            let part = line.split(",")

            let left = part[0].split("-").map{ $0.decimal! }
            let leftRange = Array(left[0]...left[1])

            let right = part[1].split("-").map{ $0.decimal! }
            let rightRange: [Int] = Array(right[0]...right[1])

            if (leftRange - rightRange).count != leftRange.count || (rightRange - leftRange).count != rightRange.count {
                counter.increment()
            }
        }

        Logger.v(self.logTag, "Result: \(counter)")
        return counter
    }

    // MARK: Day 5 - part 1
    func movingNumbersBetweenArrays(input: String) -> String {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var stack: [Int: [String]] = [:]
        func printStack() {
            for index in 1...9 {
                print("\(index): \(stack[index]?.joined() ?? "")")
            }
        }

        for line in lines {
            if line.starts(with: "move") {
                let parts = line.split(" ")
                let amount = parts[1].decimal!
                let from = parts[3].decimal!
                let to = parts[5].decimal!
                for _ in 1...amount {
                    let elem = stack[from]!.removeFirst()
                    stack[to] = [elem] + stack[to]!
                }

            } else {
                let boxes = line.array.chunked(by: 4).map { $0.joined() }
                for (index, box) in boxes.enumerated() {
                    let letter = box
                        .replacingOccurrences(of: "[", with: "")
                        .replacingOccurrences(of: "]", with: "")
                        .trimming(" ")
                    if !letter.isEmpty {
                        stack[index + 1, default: []].append(letter)
                    }
                }
            }
        }
        var letters = ""
        for index in 1...9 {
            letters.append(stack[index]?.first)
        }
        Logger.v(self.logTag, "Result: \(letters)")
        return letters
    }

    // MARK: Day 5 - part 2
    func movingMultipleNumbersBetweenArrays(input: String) -> String {
        let lines = input.split("\n").filter{ !$0.isEmpty }
        var stack: [Int: [String]] = [:]

        func printStack() {
            for index in 1...9 {
                print("\(index): \(stack[index]?.joined() ?? "")")
            }
        }

        for line in lines {
            if line.starts(with: "move") {
                let parts = line.split(" ")
                let amount = parts[1].decimal!
                let from = parts[3].decimal!
                let to = parts[5].decimal!
                let elems = stack[from]?.first(amount: amount)
                stack[to]?.prepend(elems)
                stack[from]?.removeFirst(amount: amount)
            } else {
                let boxes = line.array
                    .chunked(by: 4)
                    .map { $0.joined() }
                    .map { $0.replacingOccurrences(of: "[", with: "") }
                    .map { $0.replacingOccurrences(of: "]", with: "") }
                    .map { $0.trimming(" ") }
                for (index, letter) in boxes.enumerated() {
                    if !letter.isEmpty {
                        stack[index + 1, default: []].append(letter)
                    }
                }
            }
        }
        var letters = ""
        for index in 1...9 {
            letters.append(stack[index]?.first)
        }
        Logger.v(self.logTag, "Result: \(letters)")
        return letters
    }

    // MARK: Day 6 - part 1
    func searchingFirstUniqueSequence1(input: String) -> Int {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        let index = lines[0]
            .array
            .windowed(by: 4)
            .enumerated()
            .first {
                $0.1.unique.count == $0.1.count
            }
            .map{ $0.0 }

        let result = index + 4
        Logger.v(self.logTag, "Result: \(result)")
        return result
    }

    // MARK: Day 6 - part 2
    func searchingFirstUniqueSequence2(input: String) -> Int {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        let index = lines[0]
            .array
            .windowed(by: 14)
            .enumerated()
            .first {
                $0.1.unique.count == $0.1.count
            }
            .map{ $0.0 }

        let result = index + 14
        Logger.v(self.logTag, "Result: \(result)")
        return result
    }

    // MARK: Day 7 - part 1
    func directoryCrawling1(input: String) -> Int {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var currentPath: [String] = []
        var listingPath: [String] = []

        var fileSizes: [String: Int] = [:]
        var allDirectoryPaths: Set<String> = []

        for line in lines {
            let parts = line.split(" ")
            if parts[0].starts(with: "$") {
                // command
                switch parts[1] {
                case "cd":
                    let dirName = parts[2]
                    if dirName == ".." {
                        currentPath.removeLast(amount: 1)
                    } else {
                        currentPath.append(dirName)
                    }
                    allDirectoryPaths.insert(currentPath.joined(separator: "/"))
                    listingPath = currentPath
                case "dir":
                    listingPath = currentPath.withAppended(parts[2])
                    allDirectoryPaths.insert(listingPath.joined(separator: "/"))
                default:
                    break
                }
            } else {
                // listing files in listingPath
                if !line.starts(with: "dir") {
                    let (size, name) = parts.tuple
                    let filePath = listingPath.withAppended(name)
                    fileSizes[filePath.joined(separator: "/")] = size.decimal!
                }
            }
        }
        var dirSizes: [String: Int] = [:]
        for path in allDirectoryPaths {
            dirSizes[path] = fileSizes.filter{ $0.key.starts(with: path) }.map{ $0.value }.reduce(0, +)
        }
        let result = dirSizes.rawValues.filter{ $0 < 100000 }.reduce(0, +)
        Logger.v(self.logTag, "Result: \(result)")
        return result
    }

    // MARK: Day 7 - part 1
    func directoryCrawling2(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var currentPath: [String] = []
        var listingPath: [String] = []

        var fileSizes: [String: Int] = [:]
        var directories: Set<String> = []

        for line in lines {
            let parts = line.split(" ")
            if parts[0].starts(with: "$") {
                // command
                switch parts[1] {
                case "cd":
                    let dirName = parts[2]
                    if dirName == ".." {
                        currentPath.removeLast(amount: 1)
                    } else {
                        currentPath.append(dirName)
                    }
                    directories.insert(currentPath.joined(separator: "/"))
                    listingPath = currentPath
                case "dir":
                    listingPath = currentPath.withAppended(parts[2])
                    directories.insert(listingPath.joined(separator: "/"))
                default:
                    break
                }
            } else {
                // listing files in listingPath
                if !line.starts(with: "dir") {
                    let (size, name) = parts.tuple
                    let filePath = listingPath.withAppended(name)
                    fileSizes[filePath.joined(separator: "/")] = size.decimal!
                }
            }
        }
        var dirSizes: [String: Int] = [:]
        for path in directories {
            dirSizes[path] = fileSizes.filter{ $0.key.starts(with: path) }.map{ $0.value }.reduce(0, +)
        }
        let totalSpace = 70000000
        let requiredSpace = 30000000

        let occupiedSpace = dirSizes["/"]
        let freeSpace = totalSpace - occupiedSpace

        let needToFree = requiredSpace - freeSpace
        let result = dirSizes.filter{ $0.value >= needToFree }.map{ $0.value }.min
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 8 - part 1
    func topPointOnTheMap1(input: String) -> Int? {
        let map = PointMap(input)
        var top = Set<Point>()
        for point in map.allPoints {
            let value = map[point]
            for direction in MoveDirection.allCases {
                let trees = map.values(from: point, to: direction)
                if trees.max == value, (trees.count{ $0 == value }) == 1 {
                    top.insert(point)
                }
            }
        }

        let result: Int? = top.count
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 8 - part 1
    func topPointOnTheMap2(input: String) -> Int? {
        let map = PointMap(input)

        var totalScores: [Int] = []
        for point in map.allPoints {
            var treesInAllDirections: [Int] = []
            for direction in MoveDirection.allCases {
                var treesPerDirection = 0
                var values = map.values(from: point, to: direction)
                let value = values.first
                values.removeFirst(amount: 1)
                for nextValue in values {
                    treesPerDirection.increment()
                    if nextValue >= value! {
                        break
                    }
                }
                treesInAllDirections.append(treesPerDirection)
            }
            totalScores.append(treesInAllDirections.reduce(1, *))
        }
        let result: Int? = totalScores.max
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 9 - part 1
    func chasingPointOnMap1(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var tail = Point(x: 0, y: 0)
        var head = Point(x: 0, y: 0)

        var tailRoute = Set<Point>()
        tailRoute.insert(tail)

        var lastHeadPosition = head

        func isTouching(point: Point, other: Point) -> Bool {
            (point.linearNeighbours + point.diagonalNeighbours).contains(other) || point == other
        }
        let sideMapping: [String: MoveDirection] = ["R": .right, "L": .left, "U": .up, "D": .down]

        for line in lines {
            let (side, distance) = line.split(" ").tuple
            let direction = sideMapping[side]!
            for _ in 1...distance.decimal! {
                lastHeadPosition = head
                head = head.move(direction)
                if !isTouching(point: head, other: tail) {
                    tail = lastHeadPosition
                    tailRoute.insert(tail)
                }
            }
        }
        let result: Int? = tailRoute.count
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 9 - part 2
    func chasingPointOnMap2(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var nodes = Array(repeating: Point(x: 0, y: 0), count: 10)

        var tailRoute = Set<Point>()
        tailRoute.insert(nodes.last)

        func isTouching(point: Point, other: Point) -> Bool {
            (point.linearNeighbours + point.diagonalNeighbours).contains(other) || point == other
        }
        let sideMapping: [String: MoveDirection] = ["R": .right, "L": .left, "U": .up, "D": .down]

        for line in lines {
            let (side, distance) = line.split(" ").tuple
            let direction = sideMapping[side]!
            for _ in 1...distance.decimal! {
                nodes[0] = nodes[0].move(direction)
                for index in 1..<10 {
                    let previosNode = nodes[index.decremented]
                    var nextNode = nodes[index]

                    if !isTouching(point: nextNode, other: previosNode) {
                        if previosNode.isAbove(to: nextNode) {
                            nextNode = nextNode.move(.up)
                        }
                        if previosNode.isBelow(to: nextNode) {
                            nextNode = nextNode.move(.down)
                        }
                        if previosNode.isOnRigh(to: nextNode) {
                            nextNode = nextNode.move(.right)
                        }
                        if previosNode.isOnLeft(to: nextNode) {
                            nextNode = nextNode.move(.left)
                        }
                        nodes[index] = nextNode
                    }
                }
                tailRoute.insert(nodes.last)
            }
        }
        let result: Int? = tailRoute.count
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 10 - part 1
    func crtDisplay1(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var cycleCounter = 0
        var registerValue = 1

        var res: [Int] = []

        let snapshots = [20, 60, 100, 140, 180, 220]
        func checkSignal() {
            if snapshots.contains(cycleCounter) {
                res.append(cycleCounter * registerValue)
            }
        }

        for line in lines {
            let parts = line.split(" ")

            switch parts[0] {
            case "noop":
                cycleCounter.increment()
                checkSignal()
            case "addx":
                cycleCounter.increment()
                checkSignal()
                cycleCounter.increment()
                checkSignal()
                registerValue += parts[1].decimal
            default:
                break
            }
        }
        print(res)
        let result: Int? = res.reduce(0, +)
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 10 - part 2
    func crtDisplay2(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var horizontalPosirionCounter = 0
        var pixelPosition = 0
        var spriteCenter = 1

        var crt: [Int] = Array(repeating: 0, count: 240)

        func drawPixel() {
            if pixelPosition >= 240 {
                pixelPosition = 0
            }
            if horizontalPosirionCounter >= 40 {
                horizontalPosirionCounter = 0
            }
            let spriteRange = spriteCenter - 1...spriteCenter + 1
            if spriteRange.contains(horizontalPosirionCounter) {
                crt[pixelPosition] = 1
            }
//            print("\(horizontalPosirionCounter) \(Array(spriteRange))")
        }

        for line in lines {
            let parts = line.split(" ")

            switch parts[0] {
            case "noop":
                drawPixel()
                horizontalPosirionCounter.increment()
                pixelPosition.increment()
            case "addx":
                drawPixel()
                horizontalPosirionCounter.increment()
                pixelPosition.increment()
                drawPixel()
                horizontalPosirionCounter.increment()
                pixelPosition.increment()
                spriteCenter += parts[1].decimal
            default:
                break
            }
        }

        let led = crt.cut(into: 6)
        for y in 0..<6 {
            var line = ""
            for x in 0..<40 {
                if let value = led[safeIndex: y]?[safeIndex: x], value > 0 {
                    line.append("#")
                } else {
                    line.append(".")
                }
            }
            print(line)
        }
        let result: Int? = 0
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 11 - part 1
    func primeNumbers1(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        let groups = lines.chunked(by: 6)

        class Monkey: CustomStringConvertible {
            var id: Int = 0
            var operation: String = ""
            var onTrueDestination: Int = 0
            var onFalseDestination: Int = 0
            var devisisibleNumber: Int = 0
            var items: [Int] = []
            var function: ((Int) -> Int)?
            var counter = 0

            var description: String {
                "Monkey \(self.id): \(self.items) counter: \(self.counter)"
            }
        }

        func operation2Function(line: String) -> (Int) -> Int {
            let tmp = line.split("=")
            let parts = tmp[1].trimming(" ").split(" ")
            let number = parts[2].decimal
            switch parts[1] {
            case "+":
                if let number = number {
                    return { old in
                        old + number
                    }
                } else {
                    return { old in
                        old + old
                    }
                }
            case "*":
                if let number = number {
                    return { old in
                        old * number
                    }
                } else {
                    return { old in
                        old * old
                    }
                }
            default:
                break
            }
            fatalError("cannot parse")
        }

        var monkeys: [Int: Monkey] = [:]

        for group in groups {
            let monkey = Monkey()
            for line in group {
                let (label, value) = line.split(":").tuple
                if label.contains("Monkey") {
                    monkey.id = label.split(" ").last!.decimal!
                } else if label.contains("Starting items") {
                    monkey.items = value.split(",").map{ $0.trimming(" ") }.compactMap { $0.decimal }
                } else if label.contains("If true") {
                    monkey.onTrueDestination = value.split(" ").last!.decimal!
                } else if label.contains("If false") {
                    monkey.onFalseDestination = value.split(" ").last!.decimal!
                } else if label.contains("Test") {
                    monkey.devisisibleNumber = value.split(" ").last!.decimal!
                } else if label.contains("Operation") {
                    monkey.operation = value
                    monkey.function = operation2Function(line: value)
                }
            }
            monkeys[monkey.id] = monkey
        }

        for _ in 0..<20 {
            for monkeyID in 0..<monkeys.count {
                let monkey = monkeys[monkeyID]!
                let elems = monkey.items
                monkey.items = []
                for item in elems {
                    monkey.counter.increment()
                    let newValue = monkey.function!(item)
                    let next = Int((Double(newValue) / 3.0).rounded(.down))
                    if next % monkey.devisisibleNumber == 0 {
//                        print("Give \(next) to monkey \(monkey.onTrueDestination)")
                        monkeys[monkey.onTrueDestination]?.items.append(next)
                    } else {
//                        print("Give \(next) to monkey \(monkey.onFalseDestination)")
                        monkeys[monkey.onFalseDestination]?.items.append(next)
                    }
                }
            }
        }
        let result: Int? = monkeys.rawValues.map { $0.counter }.max(amount: 2).reduce(1, *)
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 11 - part 2
    func primeNumbers2(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        let groups = lines.chunked(by: 6)

        class Monkey: CustomStringConvertible {
            var id: Int = 0
            var operation: String = ""
            var onTrueDestination: Int = 0
            var onFalseDestination: Int = 0
            var devisisibleNumber: Int = 0
            var items: [Int] = []
            var function: ((Int) -> Int)?
            var counter = 0

            var description: String {
                "Monkey \(self.id): \(self.items) counter: \(self.counter)"
            }
        }

        func operation2Function(line: String) -> (Int) -> Int {
            let tmp = line.split("=")
            let parts = tmp[1].trimming(" ").split(" ")
            let number = parts[2].decimal
            switch parts[1] {
            case "+":
                if let number = number {
                    return { old in
                        old + number
                    }
                } else {
                    return { old in
                        old + old
                    }
                }
            case "*":
                if let number = number {
                    return { old in
                        old * number
                    }
                } else {
                    return { old in
                        return old * old
                    }
                }
            default:
                break
            }
            fatalError("cannot parse")
        }

        var monkeys: [Int: Monkey] = [:]

        for group in groups {
            let monkey = Monkey()
            for line in group {
                let (label, value) = line.split(":").tuple
                if label.contains("Monkey") {
                    monkey.id = label.split(" ").last!.decimal!
                } else if label.contains("Starting items") {
                    monkey.items = value.split(",").map{ $0.trimming(" ") }.compactMap { $0.decimal }
                } else if label.contains("If true") {
                    monkey.onTrueDestination = value.split(" ").last!.decimal!
                } else if label.contains("If false") {
                    monkey.onFalseDestination = value.split(" ").last!.decimal!
                } else if label.contains("Test") {
                    let n = value.split(" ").last!
                    monkey.devisisibleNumber = n.decimal!
                } else if label.contains("Operation") {
                    monkey.operation = value
                    monkey.function = operation2Function(line: value)
                }
            }
            monkeys[monkey.id] = monkey
        }

        let mod = monkeys.rawValues.map{ $0.devisisibleNumber }.reduce(1, *)

        for _ in 0..<10000 {
            for monkeyID in 0..<monkeys.count {
                let monkey = monkeys[monkeyID]!
                let elems = monkey.items
                monkey.items = []
                for item in elems {
                    monkey.counter.increment()
                    var newValue = monkey.function!(item)
                    newValue %= mod
                    if newValue.isMultiple(of: monkey.devisisibleNumber) {
                        monkeys[monkey.onTrueDestination]?.items.append(newValue)
                    } else {
                        monkeys[monkey.onFalseDestination]?.items.append(newValue)
                    }
                }
            }
        }
        let result: Int? = monkeys.rawValues.map { $0.counter }.max(amount: 2).reduce(1, *)
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 12 - part 1
    func shortestWay1(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var start = Point(x: 0, y: 0)
        var stop = Point(x: 0, y: 0)
        var map: [Point: Int] = [:]

        for (y, line) in lines.enumerated() {
            for (x, letter) in line.array.enumerated() {
                let point = Point(x: x, y: y)
                var letter = letter
                switch letter {
                case "S":
                    letter = "a"
                    start = point
                case "E":
                    stop = point
                    letter = "z"
                default:
                    break
                }
                map[point] = letter.ascii
            }
        }
        print("start: \(start) stop: \(stop)")
        let navi = AdjacencyList<Point>()

        for point in map.rawKeys {
            for direction in MoveDirection.allCases {
                let destination = point.move(direction)
                if let value = map[destination] {
                    let distance = value - map[point] + 1
                    if distance <= 2 {
                        navi.add(.directed, from: navi.createVertex(data: point), to: navi.createVertex(data: destination), weight: distance)
                    }
                }
            }
        }
        let startV = navi.createVertex(data: start)
        let endV = navi.createVertex(data: stop)
        let edges = navi.dijkstra(from: startV, to: endV)

        let result = edges?.count

        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 12 - part 2
    func shortestWay2(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var start = Point(x: 0, y: 0)
        var stop = Point(x: 0, y: 0)
        var map: [Point: Int] = [:]

        for (y, line) in lines.enumerated() {
            for (x, letter) in line.array.enumerated() {
                let point = Point(x: x, y: y)
                var letter = letter
                switch letter {
                case "S":
                    letter = "a"
                    start = point
                case "E":
                    stop = point
                    letter = "z"
                default:
                    break
                }
                map[point] = letter.ascii
            }
        }
        print("start: \(start) stop: \(stop)")
        let navi = AdjacencyList<Point>()

        for point in map.rawKeys {
            for direction in MoveDirection.allCases {
                let destination = point.move(direction)
                if let value = map[destination] {
                    let distance = value - map[point] + 1
                    if distance <= 2 {
                        if !(value == "a".ascii && map[point] == value) {
                            navi.add(.directed, from: navi.createVertex(data: point), to: navi.createVertex(data: destination), weight: distance)
                        }
                    }
                }
            }
        }

        let starts = map.filter{ $0.value == "a".ascii }
        var distances: [Int] = []
        var done = 0
        for d in starts {
            done.increment()
            print("checking for \(d.key) \(done)/\(starts.count)")
            let startV = navi.createVertex(data: d.key)
            let endV = navi.createVertex(data: stop)
            let edges = navi.dijkstra(from: startV, to: endV)
            if let count = edges?.count {
                distances.append(count)
            }
        }
        let result = distances.min(amount: 1).first
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 13 - part 1
    func parsingArray1(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        func parse(_ line: String) -> NestedArray {
            var currentContainer = NestedArray()
            var containers: [NestedArray] = [currentContainer]

            for var part in line.split(",") {
                while let sign = part.first, sign == "[" {
                    part.removeFirst()
                    let container = NestedArray()
                    containers.append(container)
                    currentContainer.append(container)
                    currentContainer = container
                }
                if let number = "\(part)".trimming("]").decimal {
                    let container = NestedArray(number: number)
                    currentContainer.append(container)
                }
                while let sign = part.last, sign == "]" {
                    part.removeLast()
                    containers.removeLast()
                    currentContainer = containers.last!
                }
            }

//            print("Parsing \(line) resulted in \(currentContainer)")
            return currentContainer
        }
        let pairs = lines.chunked(by: 2)
        var correctOrderIndices: [Int] = []
        for (index, pair) in pairs.enumerated() {
//            print("Pair \(index + 1)")
            let (top, bottom) = pair.tuple
            let topContainer = parse(top)
            let bottomContainer = parse(bottom)
            if topContainer < bottomContainer {
                correctOrderIndices.append(index + 1)
            }
        }
        print("correctOrderIndices: \(correctOrderIndices)")
        let result: Int? = correctOrderIndices.reduce(0, +)

        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 13 - part 2
    func parsingArray2(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        func parse(_ line: String) -> NestedArray {
            var currentContainer = NestedArray()
            var containers: [NestedArray] = [currentContainer]

            for var part in line.split(",") {
                while let sign = part.first, sign == "[" {
                    part.removeFirst()
                    let container = NestedArray()
                    containers.append(container)
                    currentContainer.append(container)
                    currentContainer = container
                }
                if let number = "\(part)".trimming("]").decimal {
                    let container = NestedArray(number: number)
                    currentContainer.append(container)
                }
                while let sign = part.last, sign == "]" {
                    part.removeLast()
                    containers.removeLast()
                    if currentContainer.hasNothing {
                        currentContainer.list = []
                    }
                    currentContainer = containers.last!
                }
            }

            var desc = currentContainer.description
            desc.removeLast()
            desc.removeFirst()
//            print("Parsing \(line) resulted in \(desc)")
            return currentContainer
        }

        var containers: [NestedArray] = []
        for line in lines {
            containers.append(parse(line))
        }
        let one = parse("[[2]]")
        let two = parse("[[6]]")
        containers.append(one)
        containers.append(two)
        containers.sort()
//        print("sorted:\n\(containers.map{ $0.description }.joined(separator: "\n"))")

        let desc = containers.map{ $0.description }
        let first = desc.firstIndex(of: one.description) + 1
        let second = desc.firstIndex(of: two.description) + 1
//        print("first: \(first)")
//        print("second: \(second)")
        let result: Int? = (first) * (desc.firstIndex(of: two.description)! + 1)

        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 14 - part 1
    func sandPouring1(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var map: [Point: String] = [:]
        for line in lines {
            let coordinates = line.split(" -> ")
            let pairs = coordinates.windowed(by: 2)
            for pair in pairs {
                let (from, to) = pair.map{ $0.split(",").compactMap{ $0.decimal } }.tuple
                let pointFrom = Point(x: from[0], y: from[1])
                let pointTo = Point(x: to[0], y: to[1])

                let line = pointFrom.straightLine(to: pointTo)
                for point in line {
                    map[point] = "#"
                }
            }
        }

        let sandStart = Point(x: 500, y: 0)

        func nextMove(sand: Point) -> Point? {
            if map[sand.move(.down)].isNil {
                return sand.move(.down)
            }
            if map[sand.move(.down).move(.left)].isNil {
                return sand.move(.down).move(.left)
            }
            if map[sand.move(.down).move(.right)].isNil {
                return sand.move(.down).move(.right)
            }
            return nil
        }

        func nextPosition() -> Point? {
            var pos = sandStart
            let maxY = map.rawKeys.map{ $0.y }.max()!
            while let next = nextMove(sand: pos) {
                pos = next
                if pos.y > maxY {
                    return nil
                }
            }
            return pos
        }

        var counter = 0
        while let sandPos = nextPosition() {
            map[sandPos] = "o"
            counter.increment()
        }
        for y in 0...10 {
            var line = ""
            for x in 494...503 {
                line.append(map[Point(x: x, y: y), default: "."])
            }
            print(line)
        }
        let result: Int? = counter

        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 14 - part 2
    func sandPouring2(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var map: [Point: String] = [:]
        for line in lines {
            let coordinates = line.split(" -> ")
            let pairs = coordinates.windowed(by: 2)
            for pair in pairs {
                let (from, to) = pair.map{ $0.split(",").compactMap{ $0.decimal } }.tuple
                let pointFrom = Point(x: from[0], y: from[1])
                let pointTo = Point(x: to[0], y: to[1])

                let line = pointFrom.straightLine(to: pointTo)
                for point in line {
                    map[point] = "#"
                }
            }
        }

        let maxY = map.rawKeys.map{ $0.y }.max()!
        let minX = map.rawKeys.map{ $0.x }.min()!
        let maxX = map.rawKeys.map{ $0.x }.max()!

        for x in minX - maxY...maxX + maxY {
            map[Point(x: x, y: maxY + 2)] = "#"
        }

        let sandStart = Point(x: 500, y: 0)
        func nextMove(sand: Point) -> Point? {
            if map[sand.move(.down)].isNil {
                return sand.move(.down)
            }
            if map[sand.move(.down).move(.left)].isNil {
                return sand.move(.down).move(.left)
            }
            if map[sand.move(.down).move(.right)].isNil {
                return sand.move(.down).move(.right)
            }
            return nil
        }

        func nextPosition() -> Point? {
            var pos = sandStart

            while let next = nextMove(sand: pos) {
                pos = next
            }
            if pos == sandStart {
                return nil
            }
            return pos
        }

        var counter = 1
        while let sandPos = nextPosition() {
            map[sandPos] = "o"
            counter.increment()
        }
        let result: Int? = counter
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 15 - part 1
    func sensorBeaconRange1(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        let theLine = 2000000

        var map: [Point: String] = [:]
        for line in lines {
            var sensor = Point(x: 0, y: 0)
            var beacon = Point(x: 0, y: 0)
            let parts = line.split(" ")
            if let x = parts[2].trimming("x=,").decimal, let y = parts[3].trimming("y=:").decimal {
                sensor = Point(x: x, y: y)
            }
            if let x = parts[8].trimming("x=,").decimal, let y = parts[9].trimming("y=").decimal {
                beacon = Point(x: x, y: y)
            }
            let verticalDistance = abs(sensor.y - beacon.y)
            let horizontalDistance = abs(sensor.x - beacon.x)
            let topDistance = horizontalDistance + verticalDistance
            // up
            var distance = topDistance
            var y = sensor.y
            while distance >= 0 {
                if y == theLine {
                    for x in (sensor.x - distance)...(sensor.x + distance) {
                        map[Point(x: x, y: y)] = "#"
                    }
                }
                distance.decrement()
                y.increment()
            }

            distance = topDistance
            y = sensor.y
            while distance >= 0 {
                if y == theLine {
                    for x in (sensor.x - distance)...(sensor.x + distance) {
                        map[Point(x: x, y: y)] = "#"
                    }
                }
                distance.decrement()
                y.decrement()
            }

            map[sensor] = "S"
            map[beacon] = "B"
        }
        func printMap() {
            let minY = map.rawKeys.map{ $0.y }.min()!
            let maxY = map.rawKeys.map{ $0.y }.max()!
            let minX = map.rawKeys.map{ $0.x }.min()!
            let maxX = map.rawKeys.map{ $0.x }.max()!
            for y in minY...maxY {
                var line = ""
                for x in minX...maxX {
                    line.append(map[Point(x: x, y: y), default: "."])
                }
                print(line)
            }
        }
//        printMap()
        let points = map.filter { $0.key.y == theLine }.filter{ $0.value == "#" }.map{ $0.value }.count
        let result: Int? = points

        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    // MARK: Day 15 - part 2
    func sensorBeaconRange2(input: String) -> Int? {
        let lines = input.split("\n").filter{ !$0.isEmpty }

        var map: [Int: [ClosedRange<Int>]] = [:]
        for line in lines {
            var sensor = Point(x: 0, y: 0)
            var beacon = Point(x: 0, y: 0)
            let parts = line.split(" ")
            if let x = parts[2].trimming("x=,").decimal, let y = parts[3].trimming("y=:").decimal {
                sensor = Point(x: x, y: y)
                map[y] = map[y, default: [0...0]].withAppended(x...x)
            }
            if let x = parts[8].trimming("x=,").decimal, let y = parts[9].trimming("y=").decimal {
                beacon = Point(x: x, y: y)
                map[y] = map[y, default: [0...0]].withAppended(x...x)
            }

            let verticalDistance = abs(sensor.y - beacon.y)
            let horizontalDistance = abs(sensor.x - beacon.x)
            let topDistance = horizontalDistance + verticalDistance
            // up
            var distance = topDistance
            var y = sensor.y
            while distance >= 0 {
                let range = (sensor.x - distance)...(sensor.x + distance)
                map[y] = ClosedRange.combine(map[y, default: [0...0]].withAppended(range))
                distance.decrement()
                y.increment()
            }

            distance = topDistance
            y = sensor.y
            while distance >= 0 {
                let range = [(sensor.x - distance)...(sensor.x + distance)]
                map[y] = ClosedRange.combine(map[y, default: [0...0]].withAppended(range))
                distance.decrement()
                y.decrement()
            }
        }

        for (y, ranges) in map {
            if ranges.count == 2, ranges[0].upperBound.incremented == ranges[1].lowerBound.decremented {
                let result = ranges[0].upperBound.incremented * 4000000 + y
                Logger.v(self.logTag, "Result: \(result)")
                return result
            }
        }

        let result: Int? = 0
        Logger.v(self.logTag, "Result: \(result.readable)")
        return result
    }

    func day25a(input: String) -> String {
        func snafu2Int(_ snafu: String) -> Int {
            var base = snafu.count.decremented
            var result = 0
            for pos in 0..<snafu.count {
                var digit = 0
                let sign = snafu[pos].string
                switch sign {
                case "-":
                    digit = -1
                case "=":
                    digit = -2
                default:
                    digit = Int(sign)!
                }
                result += digit * Int(pow(5.0, Double(base)))
                base.decrement()
            }
            return result
        }

        func int2Snafu(_ number: Int) -> String {
            var snafu = ""
            var number = number
            var base = 1
            while number > 0 {
                let rest = number % Int(pow(5.0, Double(base)))
                print("number: \(number), \(Int(pow(5.0, Double(base)))), rest: \(rest)")
                number -= rest
                base.increment()
                switch rest / 5 {
                case 0...2:
                    snafu = "\(rest)" + snafu
                case 4:
                    snafu = "-" + snafu
                case 3:
                    snafu = "=" + snafu
                default:
                    fatalError("Received \(rest)")
                }
            }
            return snafu
        }
        print("96 should be 1--1  \(int2Snafu(96))")
        let lines = input.split("\n").filter{ !$0.isEmpty }
        var sum = 0
        for line in lines {
            sum += snafu2Int(line)
            print("\(line) is \(snafu2Int(line))")
        }
        print("Sum: \(sum)")
        return "\(sum)"
    }
}

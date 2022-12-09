//
//  PointMap.swift
//
//
//  Created by Tomasz on 08/12/2022.
//

import Foundation

class PointMap {
    var map: [Point: Int] = [:]
    let size: (width: Int, height: Int)

    init(_ input: String) {
        let lines = input.split("\n").filter{ !$0.isEmpty }
        for (y, line) in lines.enumerated() {
            for (x, value) in line.array.enumerated() {
                self.map[Point(x: x, y: y)] = value.decimal!
            }
        }
        self.size = (width: lines[0].count, height: lines.count)
    }

    subscript(_ x: Int, _ y: Int) -> Int? {
        self.map[Point(x: x, y: y)]
    }

    subscript(_ point: Point) -> Int? {
        self.map[point]
    }

    var allPoints: [Point] {
        self.map.rawKeys
    }

    func values(from point: Point, to direction: MoveDirection) -> [Int] {
        var values: [Int] = []
        var nextPoint = point
        values.append(self.map[point])
        while true {
            nextPoint = nextPoint.move(direction)
            let value = self.map[nextPoint]
            if value.isNil {
                break
            }
            values.append(value)
        }
        return values
    }

    func values(from direction: MoveDirection, to point: Point) -> [Int] {
        self.values(from: point, to: direction).reversed()
    }
}

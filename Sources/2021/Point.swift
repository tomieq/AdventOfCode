//
//  Point.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

import Foundation

struct Point: CustomStringConvertible, Hashable {
    let x: Int
    let y: Int

    var description: String {
        "(x: \(self.x), y: \(self.y))"
    }

    func straightLine(to other: Point) -> [Point] {
        var points: [Point] = []

        if self.x == other.x, self.y != other.y {
            let start = min(self.y, other.y)
            let end = max(self.y, other.y)
            for y in start...end {
                points.append(Point(x: self.x, y: y))
            }
        }

        if self.y == other.y, self.x != other.x {
            let start = min(self.x, other.x)
            let end = max(self.x, other.x)
            for x in start...end {
                points.append(Point(x: x, y: self.y))
            }
        }

        return points
    }

    func diagonalLine(to other: Point) -> [Point] {
        var points: [Point] = []

        let horizontalDistance = abs(self.x - other.x)
        let verticalDistance = abs(self.y - other.y)

        guard horizontalDistance == verticalDistance, horizontalDistance != 0 else {
            return points
        }

        var leftPoint = self
        var rightPoint = other
        if rightPoint.x < leftPoint.x {
            leftPoint = other
            rightPoint = self
        }

        if leftPoint.y < rightPoint.y {
            // diagonal to up
            var point = leftPoint
            while point != rightPoint {
                points.append(point)
                point = Point(x: point.x.incremented, y: point.y.incremented)
            }
            points.append(point)
        } else {
            // diagonal to down
            var point = leftPoint
            while point != rightPoint {
                points.append(point)
                point = Point(x: point.x.incremented, y: point.y.decremented)
            }
            points.append(point)
        }
        return points
    }
}

/*
 0,0
   ______> x
  |
  |

  y
  */

extension Point {
    func move(_ direction: MoveDirection) -> Point {
        switch direction {
        case .right:
            return Point(x: self.x.incremented, y: self.y)
        case .left:
            return Point(x: self.x.decremented, y: self.y)
        case .up:
            return Point(x: self.x, y: self.y.decremented)
        case .down:
            return Point(x: self.x, y: self.y.incremented)
        }
    }
}

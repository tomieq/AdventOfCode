//
//  Range+Int.swift
//
//
//  Created by Tomasz on 15/12/2022.
//

import Foundation

extension ClosedRange<Int> {
    func without(_ elem: Int) -> [ClosedRange<Int>] {
        guard self.lowerBound <= elem, elem <= self.upperBound else {
            return [self]
        }
        if self.lowerBound == self.upperBound, self.upperBound == elem {
            return []
        }
        if elem == self.lowerBound {
            return [elem + 1...self.upperBound]
        }
        if elem == self.upperBound {
            return [self.lowerBound...elem - 1]
        }
        return [self.lowerBound...elem - 1, elem + 1...self.upperBound]
    }

    func combine(_ other: ClosedRange<Int>) -> [ClosedRange<Int>] {
        self.combine([other])
    }

    func combine(_ ranges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
        return ClosedRange<Int>.combine(ranges.withAppended(self))
    }

    static func combine(_ ranges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
        var combined = [ClosedRange<Int>]()
        var accumulator = (0...0) // empty range
        for range in ranges.sorted(by: { $0.lowerBound < $1.lowerBound }) {
            if accumulator == (0...0) {
                accumulator = range
            }

            if accumulator.upperBound >= range.lowerBound {
                accumulator = (accumulator.lowerBound...range.upperBound)
            } else if accumulator.upperBound + 1 == range.lowerBound {
                accumulator = (accumulator.lowerBound...range.upperBound)
            } else if accumulator.upperBound <= range.lowerBound {
                combined.append(accumulator)
                accumulator = range
            }
        }

        if accumulator != (0...0) {
            combined.append(accumulator)
        }
        return combined
    }
}

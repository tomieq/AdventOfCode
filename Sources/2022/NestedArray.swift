//
//  NestedArray.swift
//
//
//  Created by Tomasz on 13/12/2022.
//

import Foundation

class NestedArray {
    var number: Int?
    var list: [NestedArray]?

    var hasNothing: Bool {
        self.number.isNil && self.list.isNil
    }

    init(number: Int? = nil, list: [NestedArray]? = nil) {
        self.number = number
        self.list = list
    }

    func append(_ elem: NestedArray) {
        if self.list.isNil {
            self.list = []
        }
        self.list?.append(elem)
    }
}

extension NestedArray: CustomStringConvertible {
    var description: String {
        if let number = self.number {
            return "\(number)"
        }
        if let list = self.list {
            return "[" + list.map { $0.description }.joined(separator: ",") + "]"
        }
        return ""
    }
}

extension NestedArray: Equatable {
    static func == (lhs: NestedArray, rhs: NestedArray) -> Bool {
        if let left = lhs.number, let right = rhs.number {
            return left == right
        }
        if let left = lhs.list, let right = rhs.list {
            return left == right
        }
        if lhs.hasNothing, rhs.hasNothing {
            return true
        }
        if lhs.hasNothing, rhs.list.notNil {
            return NestedArray(list: []) == rhs
        }
        if lhs.list.notNil, lhs.hasNothing {
            return lhs == NestedArray(list: [])
        }
        return false
    }
}

extension NestedArray: Comparable {
    static func < (lhs: NestedArray, rhs: NestedArray) -> Bool {
        // two numbers
        if let left = lhs.number, let right = rhs.number {
            return left < right
        }
        // left number, right list
        if let left = lhs.number, let _ = rhs.list {
            let l = NestedArray()
            l.list = [NestedArray(number: left)]
            return l < rhs
        }
        // left list, right number
        if let _ = lhs.list, let right = rhs.number {
            let r = NestedArray()
            r.list = [NestedArray(number: right)]
            return lhs < r
        }
        // left nothing, right list
        if lhs.hasNothing, let _ = rhs.list {
            let l = NestedArray(list: [])
            return l < rhs
        }
        // left list, right nothing
        if let _ = lhs.list, rhs.hasNothing {
            let r = NestedArray(list: [])
            return lhs < r
        }
        if lhs.hasNothing, rhs.number.notNil {
            return true
        }
        if lhs.number.notNil, rhs.hasNothing {
            return false
        }
        // left list, right list
        if let left = lhs.list, let right = rhs.list {
            let limit = max(left.count, right.count)
            for i in 0..<limit {
                guard let leftValue = left[safeIndex: i] else {
                    return true
                }
                guard let rightValue = right[safeIndex: i] else {
                    return false
                }
                if leftValue == rightValue {
                    continue
                }
                return leftValue < rightValue
            }
            return false
        }
        fatalError("All cases should be covered \(lhs) \(rhs)")
    }
}

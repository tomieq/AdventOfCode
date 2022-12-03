//
//  Array+extension.swift
//
//
//  Created by Tomasz on 29/11/2022.
//

import Foundation

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        get {
            guard index >= 0, index < count else { return nil }
            return self[index]
        }

        set(newValue) {
            guard let value = newValue, index >= 0, index < count else { return }
            self[index] = value
        }
    }
}

extension Array where Element: Equatable {
    mutating func remove(object: Element?) {
        guard let object = object else {
            return
        }
        if let index = firstIndex(of: object) {
            self.remove(at: index)
        }
    }
}

extension Array {
    func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }

    func cut(into parts: Int) -> [[Element]] {
        guard self.count % parts == 0 else {
            Logger.e("Array.cut", "Cannot cut array into \(parts) subarrays as the array length is not dividable by \(parts)")
            return [self]
        }
        return self.chunked(by: self.count / parts)
    }
}

extension Array {
    func count(match: (Element) -> Bool) -> Int {
        var count: Int = 0
        for x in self {
            if match(x) {
                count = count + 1
            }
        }
        return count
    }

    func contains(match: (Element) -> Bool) -> Bool {
        for x in self {
            if match(x) {
                return true
            }
        }
        return false
    }
}

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}

extension Array where Element: Comparable {
    var min: Element? {
        guard var minimum = self[safeIndex: 0] else {
            return nil
        }
        forEach { item in
            minimum = Swift.min(minimum, item)
        }
        return minimum
    }

    var max: Element? {
        guard var maximum = self[safeIndex: 0] else {
            return nil
        }
        forEach { item in
            maximum = Swift.max(maximum, item)
        }
        return maximum
    }

    // get n elements from an array that are min
    func min(amount: Int) -> [Element] {
        guard amount > 0 else { return [] }
        var copy = self
        var result: [Element] = []
        for _ in 0..<amount {
            guard let min = copy.min else { return result }
            result.append(min)
            copy.remove(object: min)
        }
        return result
    }

    // get n elements from an array that are max
    func max(amount: Int) -> [Element] {
        guard amount > 0 else { return [] }
        var copy = self
        var result: [Element] = []
        for _ in 0..<amount {
            guard let max = copy.max else { return result }
            result.append(max)
            copy.remove(object: max)
        }
        return result
    }
}

extension Array {
    func withAppended(_ elem: Element) -> [Element] {
        var copy = self
        copy.append(elem)
        return copy
    }

    func withAppended(_ elems: [Element]) -> [Element] {
        var copy = self
        copy.append(contentsOf: elems)
        return copy
    }
}

extension Array {
    mutating func append(_ elem: Element?) {
        guard let strong = elem else {
            return
        }
        self += strong
    }
}

extension Array where Element == String {
    mutating func append(_ elem: Character?) {
        guard let elem = elem else {
            return
        }
        self.append("\(elem)")
    }

    mutating func append(_ elem: Character) {
        self.append("\(elem)")
    }
}

extension Array where Element: Hashable {
    // zwraca elementy wspólne dla obu list
    func commonElements(with other: [Element]) -> [Element] {
        Array(Set(self).intersection(Set(other)))
    }
}

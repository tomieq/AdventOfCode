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
    mutating func removeFirst(object: Element?) {
        guard let object = object else {
            return
        }
        if let index = firstIndex(of: object) {
            self.remove(at: index)
        }
    }

    mutating func removeAll(object: Element?) {
        guard let object = object else {
            return
        }
        while let index = firstIndex(of: object) {
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

    // cuts array into equal subarrays
    func cut(into parts: Int) -> [[Element]] {
        guard self.count % parts == 0 else {
            Logger.e("Array.cut", "Cannot cut array into \(parts) subarrays as the array length is not dividable by \(parts)")
            return [self]
        }
        return self.chunked(by: self.count / parts)
    }

    // creates windows out of an array
    func windowed(by size: Int, offset: Int = 1) -> [[Element]] {
        var result: [[Element]] = []
        var index = 0
        while index <= self.count - size {
            let window = self.subArray(index..<index + size)
            result.append(window)
            index += offset
        }
        return result
    }
}

extension Array {
    func subArray(_ range: Range<Int>) -> [Element] {
        Array(self[range])
    }

    func subArray(_ range: ClosedRange<Int>) -> [Element] {
        Array(self[range])
    }

    func subArray(_ range: PartialRangeFrom<Int>) -> [Element] {
        Array(self[range])
    }

    func subArray(_ range: PartialRangeThrough<Int>) -> [Element] {
        Array(self[range])
    }

    func subArray(_ range: PartialRangeUpTo<Int>) -> [Element] {
        Array(self[range])
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
            copy.removeFirst(object: min)
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
            copy.removeFirst(object: max)
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
    func removed(index: Int) -> [Element] {
        self.enumerated().filter{ $0.offset != index }.map{ $0.element }
    }
}

extension Array {
    mutating func append(_ elem: Element?) {
        guard let strong = elem else {
            return
        }
        self += strong
    }

    mutating func append(_ elems: [Element]) {
        self = elems + self
    }

    mutating func prepend(_ elem: Element?) {
        guard let strong = elem else {
            return
        }
        self = [strong] + self
    }

    mutating func prepend(_ elems: [Element]?) {
        guard let elems = elems else {
            return
        }
        self = elems + self
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

    func hasCommonElements(with other: [Element]) -> Bool {
        !Set(self).intersection(Set(other)).isEmpty
    }
}

extension Array {
    func first(amount: Int) -> [Element] {
        Array(self.prefix(amount))
    }

    func last(amount: Int) -> [Element] {
        Array(self.suffix(amount))
    }

    mutating func removeFirst(amount: Int) {
        self = Array(self.dropFirst(amount))
    }

    func removedFirst(amount: Int) -> Array {
        Array(self.dropFirst(amount))
    }

    mutating func removeLast(amount: Int) {
        self = Array(self.dropLast(amount))
    }
    
    func removedLast(amount: Int) -> Array {
        Array(self.dropLast(amount))
    }

    var reversed: [Element] {
        Array(self.reversed())
    }

    mutating func reverse() {
        self = self.reversed
    }
}

extension Array {
    var tuple: (Element, Element) {
        (self[0], self[1])
    }

    var triple: (Element, Element, Element) {
        (self[0], self[1], self[2])
    }
    
    var quadruple: (Element, Element, Element, Element) {
        (self[0], self[1], self[2], self[3])
    }
}

extension Array where Element: Comparable {
    static public func <(lhs: Array<Element>, rhs: Array<Element>) -> Bool {
          if lhs.count != rhs.count { return false }
          for i in 0..<lhs.count {
              if lhs[i] < rhs[i] { return true }
              if lhs[i] > rhs[i] { return false }
          }
          return true
     }
}

extension Array {
    func filled(with element: Element, toSize size: Int) -> Self {
        var copy = self
        while copy.count < size {
            copy.append(element)
        }
        return copy
    }
}

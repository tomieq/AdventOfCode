//
//  Stack.swift
//
//
//  Created by Tomasz on 22/12/2022.
//

import Foundation

public struct Stack<Element> {
    private var storage: [Element] = []

    public init() { }

    public init(_ elements: [Element]) {
        self.storage = elements
    }

    public mutating func push(_ element: Element?) {
        guard let element = element else { return }
        self.storage.append(element)
    }

    @discardableResult
    public mutating func pop() -> Element? {
        self.storage.popLast()
    }

    public func peek() -> Element? {
        self.storage.last
    }

    public var isEmpty: Bool {
        self.peek() == nil
    }

    public var elements: [Element] {
        self.storage
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.storage = elements
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        """
        ----top----
        \(self.storage.map { "\($0)" }.reversed().joined(separator: "\n"))
        -----------
        """
    }
}

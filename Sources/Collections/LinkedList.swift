//
//  LinkedList.swift
//
//
//  Created by Tomasz on 22/12/2022.
//

import Foundation

public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?

    public init() {}

    public var isEmpty: Bool {
        self.head == nil
    }

    // Adds a value at the front of the list.
    public mutating func push(_ value: Value) {
        self.head = Node(value: value, next: self.head)
        if self.tail == nil {
            self.tail = self.head
        }
    }

    // Adds a value at the end of the list.
    public mutating func append(_ value: Value) {
        guard !self.isEmpty else {
            self.push(value)
            return
        }
        self.tail!.next = Node(value: value)
        self.tail = self.tail!.next
    }

    // Returns a node at a particular index.
    public func node(at index: Int) -> Node<Value>? {
        var currentNode = self.head
        var currentIndex = 0
        while currentNode != nil, currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
    }

    // Adds a value after a particular list node.
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>?) -> Node<Value>? {
        guard let node = node else { return nil }
        guard self.tail !== node else {
            self.append(value)
            return self.tail!
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }

    // Removes the value at the front of the list.
    @discardableResult
    public mutating func pop() -> Value? {
        defer {
            self.head = self.head?.next
            if isEmpty {
                self.tail = nil
            }
        }
        return self.head?.value
    }

    // Removes the value at the end of the list.
    @discardableResult
    public mutating func removeLast() -> Value? {
        guard let head = head else {
            return nil
        }
        guard head.next != nil else {
            return self.pop()
        }
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        self.tail = prev
        return current.value
    }

    // Removes a value after particular list node.
    @discardableResult
    public mutating func remove(after node: Node<Value>?) -> Value? {
        guard let node = node else { return nil }
        defer {
            if node.next === tail {
                self.tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

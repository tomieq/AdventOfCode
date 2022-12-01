//
//  Queue.swift
//
//
//  Created by Tomasz on 01/12/2022.
//

import Foundation

struct Queue<T> {
    private var dataSource: [T]

    public init(_ data: [T] = []) {
        self.dataSource = data
    }

    public func isEmpty() -> Bool{
        self.dataSource.isEmpty
    }

    public mutating func enqueue(_ element: T) {
        self.dataSource.append(element)
    }

    @discardableResult
    public mutating func dequeue() -> T?{
        self.isEmpty() ? nil : self.dataSource.removeFirst()
    }

    public func peek() -> T? {
        self.isEmpty() ? nil : self.dataSource.first
    }

    public var count: Int {
        self.dataSource.count
    }
}

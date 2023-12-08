//
//  CircularVector.swift
//
//
//  Created by Tomasz on 08/12/2023.
//

import Foundation

class CircularVector<T> {
    private let array: [T]
    private var index = 0
    
    init(_ array: [T]) {
        self.array = array
    }
    
    var next: T {
        defer {
            self.index = self.index == self.array.count - 1  ? 0 : self.index + 1
        }
        return self.array[self.index]
    }
}

extension CircularVector: CustomStringConvertible {
    var description: String {
        "\(self.array)"
    }
}

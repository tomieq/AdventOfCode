//
//  Int+extension.swift
//
//
//  Created by Tomasz on 29/11/2022.
//

import Foundation

extension Int {
    var hex: String {
        String(self, radix: 16)
    }

    var binary: String {
        String(self, radix: 2)
    }

    var decimal: String {
        String(self, radix: 10)
    }
}

extension Int {
    init?(decimal: String) {
        self.init(decimal, radix: 10)
    }

    init?(binary: String) {
        self.init(binary, radix: 2)
    }

    init?(hex: String) {
        self.init(hex, radix: 16)
    }
}

extension Int {
    mutating func increment() {
        self += 1
    }

    mutating func decrement() {
        self -= 1
    }
}

extension Int {
    var incremented: Int {
        self + 1
    }

    var decremented: Int {
        self - 1
    }
}

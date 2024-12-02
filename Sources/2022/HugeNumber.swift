//
//  HugeNumber.swift
//
//
//  Created by Tomasz on 11/12/2022.
//

import Foundation

struct HugeNumber {
    fileprivate let digits: [Int]

    init(_ number: String) {
        self.digits = number.array.map { $0.decimal! }
    }

    fileprivate init(digits: [Int]) {
        self.digits = digits
    }
}

extension HugeNumber: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(value)
    }
}

extension HugeNumber: CustomStringConvertible {
    var description: String {
        self.digits.map{ "\($0)" }.joined()
    }
}

extension HugeNumber: Equatable {}

//extension HugeNumber {
//    func divisible(by divisor: Int) -> Bool {
//        switch divisor {
//        case 23:
//
//        default:
//            return false
//        }
//
//    }
//}

func + (lhs: HugeNumber, rhs: HugeNumber) -> HugeNumber {
    let lenght = max(lhs.digits.count, rhs.digits.count)
    let one = lhs.digits.reversed
    let two = rhs.digits.reversed

    var result: [Int] = []
    var rest = 0

    for index in 0..<lenght {
        let sum = rest + one[safeIndex: index] + two[safeIndex: index]
        let digit = sum % 10
        rest = (sum - digit) / 10
        result.append(digit)
    }
    if rest > 0 {
        result.append(rest)
    }
    return HugeNumber(digits: result.reversed)
}

func * (lhs: HugeNumber, rhs: HugeNumber) -> HugeNumber {
    let left = lhs.digits.reversed
    let right = rhs.digits.reversed

    var partials: [HugeNumber] = []
    for r in 0..<right.count {
        var rest = 0
        var numbers: [Int] = Array(repeating: 0, count: r)
        for l in 0..<left.count {
            let partial = rest + right[r] * left[l]
            let digit = partial % 10
            rest = (partial - digit) / 10
            numbers.append(digit)
        }
        if rest > 0 {
            numbers.append(rest)
        }
        partials.append(HugeNumber(digits: numbers.reversed()))
    }
    return partials.reduce(HugeNumber("0"), +)
}

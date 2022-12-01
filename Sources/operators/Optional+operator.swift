//
//  Optional+operator.swift
//
//
//  Created by Tomasz on 01/12/2022.
//

import Foundation

func += <T: AdditiveArithmetic>(lhs: inout T, rhs: T?) {
    guard let rhs = rhs else { return }
    lhs = lhs + rhs
}

func -= <T: AdditiveArithmetic>(lhs: inout T, rhs: T?) {
    guard let rhs = rhs else { return }
    lhs = lhs - rhs
}

func > <T: Comparable>(lhs: T, rhs: T?) -> Bool {
    guard let rhs = rhs else { return false }
    return lhs > rhs
}

func > <T: Comparable>(lhs: T?, rhs: T) -> Bool {
    guard let lhs = lhs else { return false }
    return lhs > rhs
}

func < <T: Comparable>(lhs: T, rhs: T?) -> Bool {
    guard let rhs = rhs else { return false }
    return lhs < rhs
}

func < <T: Comparable>(lhs: T?, rhs: T) -> Bool {
    guard let lhs = lhs else { return false }
    return lhs < rhs
}

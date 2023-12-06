//
//  Int+operator.swift
//
//
//  Created by Tomasz on 06/12/2022.
//

import Foundation

func + (lhs: Int, rhs: Int?) -> Int {
    guard let rhs = rhs else {
        return lhs
    }
    return lhs + rhs
}

func + (lhs: Int?, rhs: Int) -> Int {
    guard let lhs = lhs else {
        return rhs
    }
    return lhs + rhs
}

func + (lhs: Int?, rhs: Int?) -> Int {
    switch (lhs, rhs) {
    case (.some(let l), .some(let r)):
        return l + r
    case (.some(let l), .none):
        return l
    case (.none, .some(let r)):
        return r
    default:
        return 0
    }
}

func - (lhs: Int, rhs: Int?) -> Int {
    guard let rhs = rhs else {
        return lhs
    }
    return lhs - rhs
}

func * (lhs: Int, rhs: Int?) -> Int {
    guard let rhs = rhs else {
        return 0
    }
    return lhs * rhs
}

func * (lhs: Int?, rhs: Int) -> Int {
    guard let lhs = lhs else {
        return 0
    }
    return lhs * rhs
}

func * (lhs: Int?, rhs: Int?) -> Int {
    switch (lhs, rhs) {
    case (.some(let l), .some(let r)):
        return l * r
    default:
        return 0
    }
}

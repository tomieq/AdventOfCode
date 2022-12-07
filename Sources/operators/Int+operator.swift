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

func - (lhs: Int, rhs: Int?) -> Int {
    guard let rhs = rhs else {
        return lhs
    }
    return lhs - rhs
}

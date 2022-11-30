//
//  String+operator.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

import Foundation

infix operator -
func - (lhs: String, rhs: String) -> String {
    lhs.array.filter { !rhs.array.contains($0) }.joined()
}

func - (lhs: String?, rhs: String?) -> String {
    guard let lhs = lhs, let rhs = rhs else {
        return ""
    }
    return lhs.array.filter { !rhs.array.contains($0) }.joined()
}

func + (lhs: String?, rhs: String?) -> String {
    guard let lhs = lhs, let rhs = rhs else {
        return ""
    }
    return lhs + rhs
}

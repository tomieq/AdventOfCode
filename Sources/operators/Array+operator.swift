//
//  Array+operator.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

import Foundation

func - (lhs: [String], rhs: [String]) -> [String] {
    lhs.filter { !rhs.contains($0) }
}

func += <T>(lhs: inout [T], rhs: T?) {
    guard let rhs = rhs else { return }
    lhs.append(rhs)
}

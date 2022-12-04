//
//  Array+operator.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

import Foundation

func - <T: Equatable>(lhs: [T], rhs: [T]) -> [T] {
    lhs.filter { !rhs.contains($0) }
}

func += <T>(lhs: inout [T], rhs: T?) {
    guard let rhs = rhs else { return }
    lhs.append(rhs)
}

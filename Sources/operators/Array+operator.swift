//
//  Array+operator.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

import Foundation

infix operator -
func - (lhs: [String], rhs: [String]) -> [String] {
    lhs.filter { !rhs.contains($0) }
}

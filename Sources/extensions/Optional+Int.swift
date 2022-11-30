//
//  Optional+Int.swift
//
//
//  Created by Tomasz on 29/11/2022.
//

import Foundation

extension Optional where Wrapped == Int {
    var readable: String {
        switch self {
        case .some(let value):
            return "\(value)"
        case .none:
            return "nil"
        }
    }
}

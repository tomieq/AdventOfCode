//
//  Optional+String.swift
//
//
//  Created by Tomasz on 29/11/2022.
//

import Foundation

extension Optional where Wrapped == String {
    var readable: String {
        switch self {
        case .some(let value):
            return value
        case .none:
            return "nil"
        }
    }
}

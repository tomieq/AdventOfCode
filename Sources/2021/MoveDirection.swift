//
//  MoveDirection.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

import Foundation

enum MoveDirection: String, CaseIterable {
    case right
    case left
    case up
    case down
}

extension MoveDirection {
    var other: MoveDirection {
        switch self {
        case .right:
            return .left
        case .left:
            return .right
        case .up:
            return .down
        case .down:
            return .up
        }
    }
}

extension MoveDirection: CustomStringConvertible {
    var description: String {
        self.rawValue
    }
}

//
//  TupleZip.swift
//
//
//  Created by Tomasz on 10/12/2023.
//

import Foundation

enum TupleZip<L, R> {
    static func make(_ l: L?, _ r: R?) -> (L, R)? {
        guard let l = l, let r = r else {
            return nil
        }
        return (l, r)
    }
}

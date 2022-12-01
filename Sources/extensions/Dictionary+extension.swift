//
//  Dictionary+extension.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

import Foundation

extension Dictionary {
    var rawValues: [Value] {
        self.map { $0.value }
    }

    var rawKeys: [Key] {
        self.map { $0.key }
    }
}

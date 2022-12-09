//
//  Set+extension.swift
//
//
//  Created by Tomasz on 09/12/2022.
//

import Foundation

extension Set {
    mutating func insert(_ elem: Element?) {
        guard let elem = elem else { return }
        self.insert(elem)
    }
}

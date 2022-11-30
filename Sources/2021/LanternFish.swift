//
//  LanternFish.swift
//
//
//  Created by Tomasz on 30/11/2022.
//

import Foundation

class LanternCollection {
    var fish: [LanternFish] = []
}

class LanternFish {
    var timer: Int

    init(timer: Int) {
        self.timer = timer
    }

    func nextDay(collection: LanternCollection) {
        if self.timer == 0 {
            self.timer = 6
            collection.fish.append(LanternFish(timer: 8))
            return
        }
        self.timer.decrement()
    }
}

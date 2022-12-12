//
//  Optional+Range.swift
//
//
//  Created by Tomasz on 09/12/2022.
//

import Foundation

func ..< <T>(start: T, end: T?) -> Range<T> {
    guard let end = end else {
        return start..<start
    }
    return start..<end
}

func ..< <T>(start: T?, end: T) -> Range<T> {
    guard let start = start else {
        return end..<end
    }
    return start..<end
}

func ... <T>(start: T, end: T?) -> ClosedRange<T> {
    guard let end = end else {
        return start...start
    }
    return start...end
}

func ... <T>(start: T?, end: T) -> ClosedRange<T> {
    guard let start = start else {
        return end...end
    }
    return start...end
}

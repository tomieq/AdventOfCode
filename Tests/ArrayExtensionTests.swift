//
//  ArrayExtensionTests.swift
//
//
//  Created by Tomasz on 01/12/2022.
//

import XCTest
@testable import AdventOfCode

final class ArrayExtensionTests: XCTestCase {
    func test_safeIndex() throws {
        let array = [4, 6, 8]
        XCTAssertNil(array[safeIndex: 3])
        XCTAssertEqual(array[safeIndex: 1], 6)
    }

    func test_removeFirstObject() {
        var array = [1, 2, 3, 4, 2]
        array.removeFirst(object: 2)
        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(array, [1, 3, 4, 2])
    }

    func test_removeAllObject() {
        var array = [1, 2, 3, 4, 2]
        array.removeAll(object: 2)
        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array, [1, 3, 4])
    }

    func test_chunked() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let chunked = array.chunked(by: 3)
        XCTAssertEqual(chunked.count, 3)
        XCTAssertEqual(chunked[0], [1, 2, 3])
    }

    func test_count() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        XCTAssertEqual(array.count{ $0 < 4 }, 3)
    }

    func test_contains() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        XCTAssertEqual(array.contains{ $0 > 8 }, true)
    }

    func test_unique() {
        let array = [1, 2, 1, 4, 2, 6, 1, 2, 9]
        XCTAssertEqual(array.unique.count, 5)
    }

    func test_min() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        XCTAssertEqual(array.min, 1)
    }

    func test_max() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        XCTAssertEqual(array.max, 9)
    }

    func test_minArray() {
        let array = [3, 2, 1, 4, 5, 6, 7, 8, 9]
        XCTAssertEqual(array.min(amount: 3), [1, 2, 3])
    }

    func test_maxArray() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        XCTAssertEqual(array.max(amount: 3), [9, 8, 7])
    }

    func test_withAppended() {
        let array = [1, 2, 3]
        XCTAssertEqual(array.withAppended(4), [1, 2, 3, 4])
    }

    func test_withAppendedArray() {
        let array = [1, 2, 3]
        XCTAssertEqual(array.withAppended([4, 5]), [1, 2, 3, 4, 5])
    }

    func test_commonElements() {
        let one = "vJrwpWtwJgWr"
        let two = "hcsFMMfFFhFp"
        XCTAssertEqual(one.array.commonElements(with: two.array), ["p"])
    }

    func test_cut() {
        let text = "vJrwpWtwJgWrhcsFMMfFFhFp"
        let parts = text.array.cut(into: 2)
        XCTAssertEqual(parts[0].joined(), "vJrwpWtwJgWr")
        XCTAssertEqual(parts[1].joined(), "hcsFMMfFFhFp")
    }

    func test_first() {
        let list = [2, 3, 4, 6]
        XCTAssertEqual(list.first(amount: 2), [2, 3])
    }

    func test_last() {
        let list = [2, 3, 4, 6]
        XCTAssertEqual(list.last(amount: 3), [3, 4, 6])
    }

    func test_removeFirstElements() {
        var list = [2, 3, 4, 6, 9]
        list.removeFirst(amount: 3)
        XCTAssertEqual(list, [6, 9])
    }

    func test_removeLastElements() {
        var list = [2, 3, 4, 6, 9]
        list.removeLast(amount: 3)
        XCTAssertEqual(list, [2, 3])
    }

    func test_prepend() {
        var list = [2, 3, 4]
        list.prepend(1)
        XCTAssertEqual(list, [1, 2, 3, 4])
        list.prepend([5, 6])
        XCTAssertEqual(list, [5, 6, 1, 2, 3, 4])
    }

    func test_reversed() {
        let i = [1, 2, 3, 4]
        let reversed = i.reversed
        XCTAssertEqual(reversed, [4, 3, 2, 1])
    }

    func test_reverse() {
        var i = [1, 2, 3, 4]
        i.reverse()
        XCTAssertEqual(i, [4, 3, 2, 1])
    }

    func test_windowed() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array.windowed(by: 3), [[1, 2, 3], [2, 3, 4], [3, 4, 5]])
        XCTAssertEqual(array.windowed(by: 3, offset: 2), [[1, 2, 3], [3, 4, 5]])
    }
    
    func test_comparingIntArray() {
        var left: [Int] = [2]
        var right: [Int] = [3]
        XCTAssertTrue(left < right)
        left = [2, 1]
        right = [2, 2]
        XCTAssertTrue(left < right)
        left = [5, 8, 8]
        right = [6, 1, 1]
        XCTAssertTrue(left < right)
    }
}

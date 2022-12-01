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

    func test_removeObject() {
        var array = [1, 2, 3, 4, 5]
        array.remove(object: 2)
        XCTAssertEqual(array.count, 4)
        XCTAssertFalse(array.contains(2))
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
}
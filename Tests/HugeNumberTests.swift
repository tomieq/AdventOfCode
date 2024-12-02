//
//  HugeNumberTests.swift
//
//
//  Created by Tomasz on 11/12/2022.
//

import Foundation
import XCTest
@testable import AdventOfCode

class HugeNumberTests: XCTestCase {
    func test_initialization() {
        XCTAssertNotNil(HugeNumber("928456981372659128345618923456913285679138563"))

        let number: HugeNumber = "6529163740512657861284562854"
        XCTAssertEqual(number.description, "6529163740512657861284562854")
    }

    func test_adding() {
        XCTAssertEqual(HugeNumber("12") + HugeNumber("30"), HugeNumber("42"))
        XCTAssertEqual(HugeNumber("4357") + HugeNumber("3212"), HugeNumber("7569"))
        XCTAssertEqual(HugeNumber("892763429837460") + HugeNumber("982734928346214"), HugeNumber("1875498358183674"))
    }

    func test_miltiply() {
        XCTAssertEqual(HugeNumber("12") * HugeNumber("31"), HugeNumber("372"))
        XCTAssertEqual(HugeNumber("82019364") * HugeNumber("4528763418"), HugeNumber("371446295250826152"))
    }
}

import XCTest
@testable import AdventOfCode

final class AdventOfCodeTests: XCTestCase {
    func test_Integer2BinaryString() throws {
        XCTAssertEqual(22.binary, "10110")
    }

    func test_Integer2HexString() throws {
        XCTAssertEqual(22.hex, "16")
    }

    func test_Integer2DecimalString() throws {
        XCTAssertEqual(22.decimal, "22")
    }

    func test_initIntFromBinaryString() {
        XCTAssertEqual(Int(binary: "10110"), 22)
        XCTAssertEqual("10110".binary, 22)
    }

    func test_initIntFromHexString() {
        XCTAssertEqual(Int(hex: "16"), 22)
        XCTAssertEqual("16".hex, 22)
    }

    func test_initIntFromDecimalString() {
        XCTAssertEqual(Int(decimal: "102"), 102)
        XCTAssertEqual("102".decimal, 102)
    }
}

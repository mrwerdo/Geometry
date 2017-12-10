import XCTest
@testable import Geometry

extension TPointTests {
	static var allTests : [(String, (TPointTests) -> () throws -> Void)] {
		return [
            ("testAddition", testAddition),
            ("testSubtraction", testSubtraction),
            ("testMultiplication", testMultiplication),
            ("testDivision", testDivision),
            ("testNegation", testNegation),
            ("testEquality", testEquality),
            ("testComparability", testComparability),
            ("testHashability", testHashability),
            ("testCanConvertToOtherVectors", testCanConvertToOtherVectors)
		]
	}
}

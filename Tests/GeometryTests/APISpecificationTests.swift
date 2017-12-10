//
//  APISpecificationTests.swift
//  GeometryTests
//
//  Created by Andrew Thompson on 10/12/17.
//

import XCTest
@testable import Geometry

struct TPoint: VectorType {
    var x: Int
    var y: Int
    
    static var components: [WritableKeyPath<TPoint, Int>] {
        return [\.x, \.y]
    }
    
    init(x a: Int, y b: Int) {
        x = a
        y = b
    }
    
    init() {
        self.init(x: 0, y: 0)
    }
}

struct SPoint: VectorType {
    var row: Int
    var column: Int
    
    init() {
        row = 0
        column = 0
    }
    
    static var components: [WritableKeyPath<SPoint, Int>] {
        return [\.row, \.column]
    }
}

struct FPoint: VectorType {
    var x: Float
    var y: Float
    
    static var components: [WritableKeyPath<FPoint, Float>] {
        return [\.x, \.y]
    }
    
    init() { x = 0; y = 0 }
}

class TPointTests: XCTestCase {
    
    let l = TPoint(x: 1234, y: 1234)
    let r = TPoint(x: 1234, y: 1234)
    
    func testAddition() {
        XCTAssertEqual(l + r, TPoint(x: 2468, y: 2468))
        var k = l
        k += r
        XCTAssertEqual(k, TPoint(x: 2468, y: 2468))
    }
    
    func testSubtraction() {
        XCTAssertEqual(l - r, TPoint(x: 0, y: 0))
        var k = l
        k -= r
        XCTAssertEqual(k, TPoint(x: 0, y: 0))
    }
    
    func testMultiplication() {
        var k = l
        k *= r
        XCTAssertEqual(k, TPoint(x: 1522756, y: 1522756))
        XCTAssertEqual(l * r, TPoint(x: 1522756, y: 1522756))
    }
    
    func testDivision() {
        var k = l
        k /= r
        XCTAssertEqual(k, TPoint(x: 1, y: 1))
        XCTAssertEqual(l / r, TPoint(x: 1, y: 1))
    }
    
    func testNegation() {
        XCTAssertEqual(-l, TPoint(x: -1234, y: -1234))
    }
    
    func testEquality() {
        XCTAssertEqual(l, r)
    }
    
    func testComparability() {
        XCTAssertFalse(l < r)
        XCTAssertFalse(r > l)
    }
    
    func testHashability() {
        XCTAssertEqual(l.hashValue, r.hashValue)
    }
    
    func testCanConvertToOtherVectors() {
        let cartesian = TPoint(x: 0x123, y: 0x456)
        let console = SPoint(otherVector: cartesian)
        XCTAssertEqual(cartesian.x, console.row)
        XCTAssertEqual(cartesian.y, console.column)
        
        let texturePoint = FPoint(convertVector: cartesian, using: Float.init)
        XCTAssertEqual(texturePoint.x, 0x123)
        XCTAssertEqual(texturePoint.y, 0x456)
    }
}

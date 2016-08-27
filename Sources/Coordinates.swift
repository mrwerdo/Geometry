import Foundation

public protocol Countable : Equatable, Comparable {
    static func +=(a: inout Self, b: Self)
    static prefix func -(n: Self) -> Self
    static func *=(a: inout Self, b: Self)
    static func /=(a: inout Self, b: Self)
}
public extension Countable {
    static func +(a: Self, b: Self) -> Self {
        var sum = a
        sum += b
        return sum
    }
    
    static func -(a: Self, b: Self) -> Self {
        var sum = a
        sum += -b
        return sum
    }
    
    static func *(a: Self, b: Self) -> Self {
        var sum = a
        sum *= b
        return sum
    }
    
    static func /(a: Self, b: Self) -> Self {
        var sum = a
        sum /= b
        return sum
    }
}

public protocol CoordinateIn2Dimensions : Countable {
    associatedtype Measure : Countable
    
    var x: Measure { get set }
    var y: Measure { get set }
    var distanceFromOrigin: Measure { get }
}

public extension CoordinateIn2Dimensions {
    public var distanceFromOrigin: Measure {
        return x*x + y*y
    }
    
    static func +=(a: inout Self, b: Self) {
        a.x += b.x
        a.y += b.y
    }
    
    static prefix func -(n: Self) -> Self {
        var r = n
        r.x = -n.x
        r.y = -n.y
        return r
    }
    
    static func *=(a: inout Self, b: Self) {
        a.x *= b.x
        a.y *= b.y
    }
    
    static func /=(a: inout Self, b: Self) {
        a.x /= b.x
        a.y /= b.y
    }
    
    // TODO: Provide faster methods of the non-mutating countable operators.
    static func <(a: Self, b: Self) -> Bool {
        return a.distanceFromOrigin < b.distanceFromOrigin
    }
    
    static func ==(a: Self, b: Self) -> Bool {
        return a.x == b.x && a.y == b.y
    }
    
    static func >(a: Self, b: Self) -> Bool {
        return a.distanceFromOrigin > b.distanceFromOrigin
    }
}

public protocol CoordinateIn3Dimensions : CoordinateIn2Dimensions {
    var z: Measure { get set }
}

public extension CoordinateIn3Dimensions {
    public var distanceFromOrigin: Measure {
        return x*x + y*y + z*z
    }
    
    static func +=(a: inout Self, b: Self) {
        a.x += b.x
        a.y += b.y
        a.z += b.z
    }
    
    static prefix func -(n: Self) -> Self {
        var r = n
        r.x = -n.x
        r.y = -n.y
        r.z = -n.z
        return r
    }
    
    static func *=(a: inout Self, b: Self) {
        a.x *= b.x
        a.y *= b.y
        a.z *= b.z
    }
    
    static func /=(a: inout Self, b: Self) {
        a.x /= b.x
        a.y /= b.y
        a.z /= b.z
    }
    
    static func <(a: Self, b: Self) -> Bool {
        return a.distanceFromOrigin < b.distanceFromOrigin
    }
    
    static func ==(a: Self, b: Self) -> Bool {
        return a.x == b.x && a.y == b.y && a.z == b.z
    }
    
    static func >(a: Self, b: Self) -> Bool {
        return a.distanceFromOrigin > b.distanceFromOrigin
    }
}


extension Int : Countable { }
extension CGFloat : Countable { }
extension CGPoint : CoordinateIn2Dimensions { }

// TODO: This may prove to be a useless rule for defining inequalities.
// Consider this:
//      let a = CGPoint(x: 100, y: 10)
//      let b = CGPoint(x: 0, y: 11)
// then a < b is false, which seems odd.
public func <(a: CGPoint, b: CGPoint) -> Bool {
    return a.x < b.x && a.y < b.y
}

public struct Point : CoordinateIn2Dimensions {
    /// Returns a Boolean value indicating whether the two points are equal.
    ///
    /// Equality is the inverse of inequality. For any points `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - a: A point to compare.
    ///   - b: Another point to compare.
    public static func ==(a: Point, b: Point) -> Bool {
        return b.x == b.x && a.y == b.y
    }

    public var x: Int
    public var y: Int
    
    public init() {
        x = 0
        y = 0
    }
    
    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

// MARK: - Areas

public protocol CountableArea : Comparable {
    associatedtype Measure: Countable
    
    var width: Measure { get set }
    var height: Measure { get set }
}

public extension CountableArea {
    var area: Measure {
        return width * height
    }
    
    static func <(a: Self, b: Self) -> Bool {
        return a.area < b.area
    }
}

public struct Size : CountableArea {

    public var width: Int
    public var height: Int
    
    public init() { width = 0; height = 0 }
    public init(_ width: Int, _ height: Int) {
        self.width = width
        self.height = height
    }
}

public func ==(lhs: Size, rhs: Size) -> Bool {
    return (lhs.width == rhs.width) && (lhs.height == rhs.height)
}

extension CGSize : CountableArea {
    public var area: CGFloat {
        return width * height
    }
}
extension CGRect {
    var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2) + origin
    }
}

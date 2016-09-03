import Foundation

public protocol Countable : Equatable, Comparable {
    static func +=(a: inout Self, b: Self)
    static prefix func -(n: Self) -> Self
    static func *=(a: inout Self, b: Self)
    static func /=(a: inout Self, b: Self)
    
    static func +(a: Self, b: Self) -> Self
    static func -(a: Self, b: Self) -> Self
    static func *(a: Self, b: Self) -> Self
    static func /(a: Self, b: Self) -> Self
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

// Note:    The operators in this extension must overload the operators in the
//          extension `CoordinateIn2Dimensions` above.
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


public protocol CountableArea : Comparable {
    associatedtype Measure: Countable
    
    var width: Measure { get set }
    var height: Measure { get set }
    var area: Measure { get }
}

public extension CountableArea {
    var area: Measure {
        return width * height
    }
    
    static func ==(a: Self, b: Self) -> Bool {
        return a.width == b.width && a.height == b.height
    }
    
    static func <(a: Self, b: Self) -> Bool {
        return a.area < b.area
    }
    
    static func >(a: Self, b: Self) -> Bool {
        return a.area > b.area
    }
}

// -----------------------------------------------------------------------------
// MARK: - Countable Protocol Conformance
// -----------------------------------------------------------------------------

extension Int : Countable { }
extension CGFloat : Countable { }

// -----------------------------------------------------------------------------
// MARK: - Coordinate Protocol Conformance
// -----------------------------------------------------------------------------

extension CGPoint : CoordinateIn2Dimensions { }

extension CGVector : CoordinateIn2Dimensions {
    public var x: CGFloat {
        get { return dx }
        set { dx = newValue }
    }
    
    public var y: CGFloat {
        get { return dy }
        set { dy = newValue }
    }
}

extension CGSize : CountableArea { }

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2) + origin
    }
}

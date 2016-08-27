import Foundation

/// Merges the values of `lhs` and `rhs` by calling `op` on the members `x` and `y` of `Point`.
private func point_operator(_ lhs: CGPoint, rhs: CGPoint, op: (_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat) -> CGPoint {
    return CGPoint(x: op(lhs.x, rhs.x), y: op(lhs.y, rhs.y))
}

public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return point_operator(lhs, rhs: rhs, op: +)
}
public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return point_operator(lhs, rhs: rhs, op: -)
}
public func *(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return point_operator(lhs, rhs: rhs, op: *)
}
public func /(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return point_operator(lhs, rhs: rhs, op: /)
}
public func ==(lhs: CGPoint, rhs: CGPoint) -> Bool {
    return (lhs.x == rhs.x) && (lhs.y == rhs.y)
}

/// Merges the values of `lhs` and `rhs` by calling `op` on the members `width` and `height` of `Size`.
private func size_operator(_ lhs: CGSize, rhs: CGSize, op: (_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat) -> CGSize {
    return CGSize(width: op(lhs.width, rhs.width), height: op(lhs.height, rhs.height))
}

public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return size_operator(lhs, rhs: rhs, op: +)
}
public func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return size_operator(lhs, rhs: rhs, op: -)
}
public func ==(lhs: CGSize, rhs: CGSize) -> Bool {
    return (lhs.width == rhs.width) && (lhs.height == rhs.height)
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: width / 2.0, y: height / 2.0) + origin
    }
}

// These structures use integers rather than the core graphics equivelant.
// This avoids floating point error makes the code easier write.

public struct Point {
    public var x: Int
    public var y: Int
    
    public init() { x = 0; y = 0 }
    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

/// Merges the values of `lhs` and `rhs` by calling `op` on the members `x` and `y` of `Point`.
private func point_operator(_ lhs: Point, rhs: Point, op: (_ lhs: Int, _ rhs: Int) -> Int) -> Point {
    return Point(op(lhs.x, rhs.x), op(lhs.y, rhs.y))
}

public func +(lhs: Point, rhs: Point) -> Point {
    return point_operator(lhs, rhs: rhs, op: +)
}
public func -(lhs: Point, rhs: Point) -> Point {
    return point_operator(lhs, rhs: rhs, op: -)
}
public func *(lhs: Point, rhs: Point) -> Point {
    return point_operator(lhs, rhs: rhs, op: *)
}
public func /(lhs: Point, rhs: Point) -> Point {
    return point_operator(lhs, rhs: rhs, op: /)
}
public func %(lhs: Point, rhs: Point) -> Point {
    return point_operator(lhs, rhs: rhs, op: %)
}
func ==(lhs: Point, rhs: Point) -> Bool {
    return (lhs.x == rhs.x) && (lhs.y == rhs.y)
}

public struct Size {
    public var width: Int
    public var height: Int
    
    public init() { width = 0; height = 0 }
    public init(_ width: Int, _ height: Int) {
        self.width = width
        self.height = height
    }
}

/// Merges the values of `lhs` and `rhs` by calling `op` on the members `width` and `height` of `Size`.
private func size_operator(_ lhs: Size, rhs: Size, op: (_ lhs: Int, _ rhs: Int) -> Int) -> Size {
    return Size(op(lhs.width, rhs.width), op(lhs.height, rhs.height))
}

public func +(lhs: Size, rhs: Size) -> Size {
    return size_operator(lhs, rhs: rhs, op: +)
}
public func -(lhs: Size, rhs: Size) -> Size {
    return size_operator(lhs, rhs: rhs, op: -)
}
public func ==(lhs: Size, rhs: Size) -> Bool {
    return (lhs.width == rhs.width) && (lhs.height == rhs.height)
}

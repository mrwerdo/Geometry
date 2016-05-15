import Foundation

/// Merges the values of `lhs` and `rhs` by calling `op` on the members `x` and `y` of `Point`.
private func point_operator(_ lhs: CGPoint, rhs: CGPoint, op: (lhs: CGFloat, rhs: CGFloat) -> CGFloat) -> CGPoint {
    return CGPoint(x: op(lhs: lhs.x, rhs: rhs.x), y: op(lhs: lhs.y, rhs: rhs.y))
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
public func %(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return point_operator(lhs, rhs: rhs, op: %)
}
public func ==(lhs: CGPoint, rhs: CGPoint) -> Bool {
    return (lhs.x == rhs.x) && (lhs.y == rhs.y)
}

/// Merges the values of `lhs` and `rhs` by calling `op` on the members `width` and `height` of `Size`.
private func size_operator(_ lhs: CGSize, rhs: CGSize, op: (lhs: CGFloat, rhs: CGFloat) -> CGFloat) -> CGSize {
    return CGSize(width: op(lhs: lhs.width, rhs: rhs.width), height: op(lhs: lhs.height, rhs: rhs.height))
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
    var x: Int
    var y: Int
    
    init() { x = 0; y = 0 }
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

/// Merges the values of `lhs` and `rhs` by calling `op` on the members `x` and `y` of `Point`.
private func point_operator(_ lhs: Point, rhs: Point, op: (lhs: Int, rhs: Int) -> Int) -> Point {
    return Point(op(lhs: lhs.x, rhs: rhs.x), op(lhs: lhs.y, rhs: rhs.y))
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
private func size_operator(_ lhs: Size, rhs: Size, op: (lhs: Int, rhs: Int) -> Int) -> Size {
    return Size(op(lhs: lhs.width, rhs: rhs.width), op(lhs: lhs.height, rhs: rhs.height))
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

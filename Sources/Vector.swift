//
//  Vector.swift
//  GeometryPackageDescription
//
//  Created by Andrew Thompson on 9/12/17.
//

import Foundation

public protocol VectorType: Countable  {
    associatedtype Value: Countable
    
    static var components: [WritableKeyPath<Self, Value>] { get }
    
    /// Constructs the Unit Vector.
    init()
}

public extension VectorType {
    init(components: [Value]) {
        self.init()
        for (property, value) in zip(Self.components, components) {
            self[keyPath: property] = value
        }
    }
    
    init<Other: VectorType>(vector: Other) where Other.Value == Self.Value {
        let components = Other.components.map { vector[keyPath: $0] }
        self.init(components: components)
    }
    
    static var zero: Self {
        return Self()
    }
}

public extension VectorType {
    static func +(lhs: Self, rhs: Self) -> Self {
        return self.init(components: Self.components.map {
            lhs[keyPath: $0] + rhs[keyPath: $0]
        })
    }
    
    static func -(lhs: Self, rhs: Self) -> Self {
        return self.init(components: Self.components.map {
            lhs[keyPath: $0] - rhs[keyPath: $0]
        })
    }
}

public extension VectorType {
    static prefix func -(this: Self) -> Self {
        return self.init(components: Self.components.map {
            -this[keyPath: $0]
        })
    }
}

public extension VectorType {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        for p in Self.components where lhs[keyPath: p] != rhs[keyPath: p] {
            return false
        }
        return true
    }

    static func >(lhs: Self, rhs: Self) -> Bool {
        for p in Self.components where lhs[keyPath: p] <= rhs[keyPath: p] {
            return false
        }
        return true
    }
    
    static func <(lhs: Self, rhs: Self) -> Bool {
        for p in Self.components where lhs[keyPath: p] >= rhs[keyPath: p] {
            return false
        }
        return true
    }
    
    public var hashValue: Int {
        return Self.components.description.hashValue // FIXME: This hash algorithm is inefficient.
    }
}

public struct Point: VectorType {
    public var x: Int
    public var y: Int
    
    public init(x: Int = 0, y: Int = 0) {
        self.x = x
        self.y = y
    }
    
    public init() {
        self.init(x: 0, y: 0)
    }
    
    public static var components: [WritableKeyPath<Point, Int>] {
        return [
            \Point.x,
            \Point.y
        ]
    }
}

public struct Size: VectorType {
    public var width: Int
    public var height: Int
    
    public init(width: Int = 0, height: Int = 0) {
        self.width = width
        self.height = height
    }
    
    public init() {
        self.init(width: 0, height: 0)
    }
    
    public static var components: [WritableKeyPath<Size, Int>] {
        return [
            \Size.width,
            \Size.height
        ]
    }
}

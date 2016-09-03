// -----------------------------------------------------------------------------
// MARK: - Coordinate Concrete Types
// -----------------------------------------------------------------------------

public struct Point2D : CoordinateIn2Dimensions {
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

public struct Point3D : CoordinateIn3Dimensions {
    public var x: Int
    public var y: Int
    public var z: Int
    
    public init() {
        x = 0
        y = 0
        z = 0
    }
    
    public init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
    public init(tuple: (x: Int, y: Int, z: Int)) {
        self.x = tuple.x
        self.y = tuple.y
        self.z = tuple.z
    }
}

public struct Size : CountableArea {
    public var width: Int
    public var height: Int
    
    public init() {
        width = 0
        height = 0
    }
    
    public init(_ width: Int, _ height: Int) {
        self.width = width
        self.height = height
    }
}

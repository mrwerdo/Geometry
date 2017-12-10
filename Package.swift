// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Geometry",
    products: [
        .executable(name: "synthesize", targets: ["ProtocolSynthesis"]),
        .library(name: "Geometry", targets: ["Geometry"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "ProtocolSynthesis",
            dependencies: ["SwiftCLI"]
        ),
        .target(
            name: "Geometry",
            dependencies: []
        ),
        .testTarget(name: "GeometryTests", dependencies: ["Geometry"])
    ]
)

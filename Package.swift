// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Geometry",
    products: [
        .executable(name: "synthesize", targets: ["ProtocolSynthesis"]),
        .library(name: "Geometry", targets: ["Geometry"]),
    ],
    targets: [
        .target(
            name: "ProtocolSynthesis",
            dependencies: []
        ),
        .target(
            name: "Geometry",
            dependencies: []
        )
    ]
)

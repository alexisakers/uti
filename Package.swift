// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "uti",
    dependencies: [
    ],
    targets: [
        .target(
            name: "TypeKit",
            dependencies: []),
        .target(
            name: "uti",
            dependencies: ["TypeKit"]),
        .testTarget(
            name: "TypeKitTests",
            dependencies: ["TypeKit"])
    ]
)

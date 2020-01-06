// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Vanity",
    platforms: [ .iOS(.v11) ],
    products: [
        .library(
            name: "Vanity",
            targets: ["Vanity"]),
    ],
    targets: [
        .target(
            name: "Vanity",
            dependencies: []),
        .testTarget(
            name: "VanityTests",
            dependencies: ["Vanity"]),
    ]
)

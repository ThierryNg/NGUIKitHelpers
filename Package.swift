// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NGUIKitHelpers",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "NGUIKitHelpers",
            targets: ["NGUIKitHelpers"]),
    ],
    targets: [
        .target(
            name: "NGUIKitHelpers",
            dependencies: [],
            path: "Sources"),
    ]
)

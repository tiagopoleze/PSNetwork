// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PSNetwork",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v15), .watchOS(.v7)],
    products: [
        .library(name: "PSNetwork", targets: ["PSNetwork"]),
        .library(name: "PSNetworkVapor", targets: ["PSNetworkVapor"])
    ],
    dependencies: [
        .package(url: "https://github.com/tiagopoleze/PSCore", branch: "main"),
        .package(url: "https://github.com/vapor/vapor", from: "4.0.0")
    ],
    targets: [
        .target(name: "PSNetwork", dependencies: [.product(name: "PSCore", package: "pscore")]),
        .target(name: "PSNetworkVapor", dependencies: ["PSNetwork", .product(name: "Vapor", package: "vapor")]),
        .testTarget(name: "PSNetworkTests", dependencies: ["PSNetwork"], resources: [.process("other.json")]),
        .testTarget(name: "PSNetworkVaporTests", dependencies: ["PSNetworkVapor"])
    ]
)

// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PSNetwork",
    products: [.library(name: "PSNetwork", targets: ["PSNetwork"])],
    dependencies: [
        .package(url: "https://github.com/apple/swift-http-types.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "PSNetwork", dependencies: [.product(name: "HTTPTypes", package: "swift-http-types"),
                                                  .product(name: "HTTPTypesFoundation", package: "swift-http-types")]),
        .testTarget(name: "PSNetworkTests", dependencies: ["PSNetwork"], resources: [.process("other.json")])
    ]
)

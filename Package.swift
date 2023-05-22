// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PSNetwork",
    products: [.library(name: "PSNetwork", targets: ["PSNetwork"])],
    targets: [
        .target(name: "PSNetwork"),
        .testTarget(name: "PSNetworkTests", dependencies: ["PSNetwork"])
    ]
)

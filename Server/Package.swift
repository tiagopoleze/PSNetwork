// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Server",
    platforms: [.macOS(.v10_15)],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.0.0"),
        .package(path: "../PSNetwork"),
        .package(path: "../PSNetworkSharedLibrary")
    ],
    targets: [
        .executableTarget(name: "Server", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "PSNetwork", package: "PSNetwork"),
            .product(name: "PSNetworkVapor", package: "PSNetwork"),
            .product(name: "PSNetworkSharedLibrary", package: "PSNetworkSharedLibrary")
        ]),
        .testTarget(name: "ServerTests", dependencies: ["Server"])]
)

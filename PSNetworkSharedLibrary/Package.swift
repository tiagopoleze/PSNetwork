// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PSNetworkSharedLibrary",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v15), .watchOS(.v7)],
    products: [.library(name: "PSNetworkSharedLibrary", targets: ["PSNetworkSharedLibrary"])],
    dependencies: [.package(path: "../PSNetwork")],
    targets: [
        .target(name: "PSNetworkSharedLibrary", dependencies: ["PSNetwork"]),
        .testTarget(name: "PSNetworkSharedLibraryTests", dependencies: ["PSNetworkSharedLibrary"])
    ]
)

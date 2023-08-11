// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EasyCamera",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "EasyCamera",
            targets: ["EasyCamera"]),
    ],
    targets: [
        .target(
            name: "EasyCamera"),
    ]
)

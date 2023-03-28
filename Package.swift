// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenSphericalCamera",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "OpenSphericalCamera", targets: [ "OpenSphericalCamera" ]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/KindKit/KindKit.git",
            from: "0.5.0"
        )
    ],
    targets: [
        .target(
            name: "OpenSphericalCamera",
            dependencies: [
                .product(name: "KindKit", package: "KindKit")
            ]
        ),
        .testTarget(
            name: "OpenSphericalCameraTests",
            dependencies: [
                "OpenSphericalCamera"
            ]
        )
    ]
)

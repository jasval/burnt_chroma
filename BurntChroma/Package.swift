// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
// Swift Package: BurntChroma

import PackageDescription;

let package = Package(
    name: "BurntChroma",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "BurntChroma",
            targets: ["BurntChroma"]
        )
    ],
    dependencies: [ ],
    targets: [
        .binaryTarget(name: "RustFramework", path: "./RustFramework.xcframework"),
        .target(
            name: "BurntChroma",
            dependencies: [
                .target(name: "RustFramework")
            ]
        ),
    ]
)

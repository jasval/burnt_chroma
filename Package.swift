// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	platforms: [
		.macOS(.v10_15),
		.iOS(.v13),
		.tvOS(.v13),
		.watchOS(.v6)
	],
	name: "SwiftBurntChroma",
	products: [
		.library(
			name: "SwiftBurntChroma",
			targets: ["SwiftBurntChroma"]),
	],
	dependencies: [],
	targets: [
		.binaryTarget(
			name: "RustXcframework",
			path: "RustXcframework.xcframework"
		),
		.target(
			name: "SwiftBurntChroma",
			dependencies: ["RustXcframework"])
	],
	version: "0.3.0"
)
	
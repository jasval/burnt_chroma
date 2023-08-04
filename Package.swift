// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "SwiftBurntChroma",
	platforms: [
		.iOS(.v15),
		.macOS(.v12),
		.watchOS(.v8),
		.tvOS(.v15)
	],
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
	]
)
	
// swift-tools-version:5.5

import PackageDescription

let package = Package(
	name: "swift-MLCommon",
	platforms: [
		.macOS(.v12),
		.iOS(.v15)
	],
	products: [
		.library(name: "MLCommon", targets: ["MLCommon"]),
	],
	dependencies: {
		var dependencies: [Package.Dependency] = [
			.package(url: "https://github.com/apple/swift-crypto.git", .branch("main"))
		]
#if !os(Linux)
		dependencies.removeAll()
#endif
		return dependencies
	}(),
	targets: {
		let targets: [Target] = [
			.target(name: "MLCommon")
		]
#if os(Linux)
		targets[0].dependencies = [.product(name: "Crypto", package: "swift-crypto")]
		targets[0].exclude = ["MLLogger.swift"]
#endif
		return targets
	}()
)

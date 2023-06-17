// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "Networking",
            type: .static,
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.4"))
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: ["Alamofire"]),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"])
        
    ],
    swiftLanguageVersions: [.v5]
)

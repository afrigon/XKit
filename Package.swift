// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "XKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .macCatalyst(.v18),
        .watchOS(.v10),
        .tvOS(.v18),
        .visionOS(.v2)
    ],
    products: [
        .library(name: "XKit", targets: ["XKit"])
    ],
    targets: [
        .target(name: "XKit"),
        .testTarget(
            name: "XKitTests",
            dependencies: ["XKit"]
        )
    ]
)

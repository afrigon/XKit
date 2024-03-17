// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "XKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .macCatalyst(.v17),
        .watchOS(.v10),
        .tvOS(.v17),
        .visionOS(.v1)
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

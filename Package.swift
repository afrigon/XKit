// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "XKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "XKit", targets: ["XKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kean/Nuke.git", exact: "11.3.0")
    ],
    targets: [
        .target(
            name: "XKit",
            dependencies: [
                .product(name: "NukeUI", package: "Nuke")
            ]
        ),
        .testTarget(
            name: "XKitTests",
            dependencies: ["XKit"]
        )
    ]
)

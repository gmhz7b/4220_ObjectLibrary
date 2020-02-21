// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "ObjectLibrary",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ObjectLibrary",
            targets: ["ObjectLibrary"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ObjectLibrary",
            dependencies: []
        )
    ]
)

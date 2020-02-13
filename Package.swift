// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SwiftTypedRouter",
    products: [
        .library(name: "SwiftTypedRouter", targets: ["SwiftTypedRouter"]),
    ],
    targets: [
        .target(
            name: "SwiftTypedRouter",
            path: "SwiftTypedRouter/Classes"
        ),
        .testTarget(
            name: "SwiftTypedRouterTests",
            dependencies: [ "SwiftTypedRouter" ],
            path: "Example/Tests"
        )
    ]
)

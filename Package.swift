// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Pitchy",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "Pitchy", targets: ["Pitchy"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "7.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "13.0.0")
    ],
    targets: [
        .target(
            name: "Pitchy",
            dependencies: [],
            path: "Sources/Pitchy",
            swiftSettings: [.swiftLanguageMode(.v6)]
        ),
        .testTarget(
            name: "PitchyTests",
            dependencies: ["Pitchy", "Quick", "Nimble"],
            path: "Tests/PitchyTests",
            swiftSettings: [.swiftLanguageMode(.v5)] // update to 6 later
        )
    ]
)
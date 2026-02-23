// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Pitchy",
    platforms: [
        .iOS(.v18),
        .macOS(.v14)
    ],
    products: [ .library(name: "Pitchy", targets: ["Pitchy"]) ],
    targets: [ .target(name: "Pitchy", path: "Source") ]
)
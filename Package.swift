// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Dice", // Defines the package name as Dice
    platforms: [
        .macOS(.v14), // macOS 14 and later
        .iOS(.v17) // iOS 17 and later
    ], // Specifies the platforms supported by the package
    products: [
        .library(
            name: "Dice",
            targets: ["Dice"]) // Defines the library product with the target Dice
    ], // Lists the products of the package
    dependencies: [
        .package(url: "https://github.com/eonist/JSONSugar.git", branch: "master"), // Adds JSONSugar as a dependency
        .package(url: "https://github.com/sentryco/Logger.git", branch: "main") // Adds Logger as a dependency
    ], // Lists the dependencies of the package
    targets: [
        .target(
            name: "Dice",
            dependencies: ["JSONSugar", "Logger"], // Adds JSONSugar and Logger as dependencies for the Dice target
            resources: [.process("Resources")]), // Include the "Resources" directory as a resource
        .testTarget(
            name: "DiceTests",
            dependencies: ["Dice"]) // Defines the DiceTests target with a dependency on Dice
    ] // Lists the targets of the package
)

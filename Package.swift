// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import CompilerPluginSupport


let package = Package(
    name: "BudMacro",
    platforms: [.macOS(.v26), .iOS(.v26)],
    products: [
        // MARK: BudMacro
        .library(
            name: "BudMacro",
            targets: ["BudMacro"]
        ),
        .executable(
            name: "BudMacroClient",
            targets: ["BudMacroClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
    ],
    targets: [
        // BudMacroCore
        .macro(
            name: "BudMacroCore",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        // BudMacro
        .target(
            name: "BudMacro",
            dependencies: ["BudMacroCore"]
        ),

        
        // BudMacroClient
        .executableTarget(name: "BudMacroClient", dependencies: ["BudMacro"]),

        // BudMacroTests
        .testTarget(
            name: "BudMacroTests",
            dependencies: [
                "BudMacroCore",
                .product(name: "SwiftSyntaxMacrosTestSupport",
                         package: "swift-syntax"),
            ]
        ),
    ]
)

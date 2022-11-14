// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Onboarding",
    platforms: [.iOS(.v12), .macCatalyst(.v13), .tvOS(.v12)],
    products: [
        .library(name: "Onboarding", targets: ["Onboarding"])
    ],
    targets: [
        .target(name: "Onboarding", dependencies: []),
        .testTarget(name: "OnboardingTests", dependencies: ["Onboarding"])
    ]
)

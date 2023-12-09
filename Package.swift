// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Onboarding",
    platforms: [.iOS(.v13), .macCatalyst(.v13), .tvOS(.v13), .visionOS(.v1)],
    products: [
        .library(name: "Onboarding", targets: ["Onboarding"])
    ],
    targets: [
        .target(name: "Onboarding", dependencies: []),
        .testTarget(name: "OnboardingTests", dependencies: ["Onboarding"])
    ]
)

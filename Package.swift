// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Onboarding",
    platforms: [.iOS(.v11), .tvOS(.v11)],
    products: [
        .library(name: "Onboarding", targets: ["Onboarding"])
    ],
    targets: [
        .target(name: "Onboarding", dependencies: []),
        .testTarget(name: "OnboardingTests", dependencies: ["Onboarding"])
    ]
)

// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-rfc-3986-coder",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "RFC 3986 Coder",
            targets: ["RFC 3986 Coder"]
        ),
        .library(
            name: "RFC 3986 Coder Foundation Integration",
            targets: ["RFC 3986 Coder Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-ascii.git", branch: "main", traits: ["Parser", "Serializer"]),
        .package(url: "https://github.com/swift-standards/swift-ipv4-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-standards/swift-ipv6-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-byte.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-coder.git", branch: "main", traits: ["Checkpoint", "Map", "Pair", "Predicate", "Repetition", "Skip", "Choice", "Either", "IteratorLeaves"]),
        .package(url: "https://github.com/swift-atoms/swift-cursor.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-either.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-parser.git", branch: "main", traits: ["Always", "Choice", "Either", "FlatMap", "IteratorLeaves", "Map", "Repetition"]),
        .package(url: "https://github.com/swift-atoms/swift-serializer.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3986.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-791-coder.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-4291-coder.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-5952-coder.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-binary.git", branch: "main", traits: ["Serializer"]),
    ],
    targets: [
        .target(
            name: "RFC 3986 Coder",
            dependencies: [
                .product(name: "ASCII", package: "swift-ascii"),
                .product(name: "IPv4 Standard", package: "swift-ipv4-standard"),
                .product(name: "IPv6 Standard", package: "swift-ipv6-standard"),
                .product(name: "Byte", package: "swift-byte"),
                .product(name: "Coder", package: "swift-coder"),
                .product(name: "Cursor", package: "swift-cursor"),
                .product(name: "Cursor", package: "swift-cursor"),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "RFC 791 Coder", package: "swift-rfc-791-coder"),
                .product(name: "RFC 4291 Coder", package: "swift-rfc-4291-coder"),
                .product(name: "RFC 5952 Coder", package: "swift-rfc-5952-coder"),
                .product(name: "Serializer", package: "swift-serializer"),
                .product(name: "Binary", package: "swift-binary"),
            ]
        ),
        .testTarget(
            name: "RFC 3986 Coder Tests",
            dependencies: [
                "RFC 3986 Coder",
                .product(name: "ASCII", package: "swift-ascii"),
                .product(name: "Byte", package: "swift-byte"),
                .product(name: "Coder", package: "swift-coder"),
                .product(name: "Coder", package: "swift-coder"),
                .product(name: "Cursor", package: "swift-cursor"),
                .product(name: "IPv6 Standard", package: "swift-ipv6-standard"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "Serializer", package: "swift-serializer"),
                .product(name: "Binary", package: "swift-binary"),
            ]
        ),
        .target(
            name: "RFC 3986 Coder Foundation Integration",
            dependencies: [
                "RFC 3986 Coder",
                .product(name: "ASCII", package: "swift-ascii"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
            ]
        ),
        .testTarget(
            name: "RFC 3986 Coder Foundation Integration Tests",
            dependencies: [
                "RFC 3986 Coder Foundation Integration",
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}

// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "FFUtils",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "FFUtils",
            targets: [
                "AppIcon",
                "Collection",
                "Common",
                "CustomView",
                "Extension",
                "KeyBoard",
                "Services",
                "Table",
            ]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AppIcon",
            dependencies: [
            ]
        ),
        .target(
            name: "Collection",
            dependencies: [
            ]
        ),
        .target(
            name: "Common",
            dependencies: [
            ]
        ),
        .target(
            name: "CustomView",
            dependencies: [
            ]
        ),
        .target(
            name: "Extension",
            dependencies: [
            ]
        ),
        .target(
            name: "KeyBoard",
            dependencies: [
            ]
        ),
        .target(
            name: "Services",
            dependencies: [
            ]
        ),
        .target(
            name: "Table",
            dependencies: [
                "Extension"
            ]
        ),
    ]
)

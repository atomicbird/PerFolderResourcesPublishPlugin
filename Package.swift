// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "PerFolderResourcesPublishPlugin",
    products: [
        .library(
            name: "PerFolderResourcesPublishPlugin",
            targets: ["PerFolderResourcesPublishPlugin"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/atomicbird/publish.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "PerFolderResourcesPublishPlugin",
            dependencies: ["Publish"]
        )
    ]
)

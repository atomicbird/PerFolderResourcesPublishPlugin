# Per-folder resources for Publish
                            
A [Publish](https://github.com/atomicbird/publish) plugin that copies per-folder resources to the same location in the static site output.

By default, Publish's `copyResources()` step copies a single file of resources from the unpublished content folder to the static site output folder. This extension traverses the content folder to find resources in any folder and copies them to an output folder with the same folder path.

This may be useful if, for example, your site contains blog posts or other individual pages where inline images or other resources are in the same directory as the post's Markdown file.

For purposes of this plugin, "resources" means anything that's not a Markdown or text file.

**Note:** Currently this plugin depends on [a fork of Publish](https://github.com/atomicbird/publish), which adds the `.gitignore`-ish `shouldIgnore(name:)` function to `Website`. If this seems useful to you, please comment on the [pull request](https://github.com/JohnSundell/Publish/pull/121).
                                                      
## Installation

To install it into your [Publish](https://github.com/atomicbird/publish) package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(name: "PerFolderResourcesPublishPlugin", url: "https://github.com/atomicbird/PerFolderResourcesPublishPlugin", from: "0.1.0")
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "PerFolderResourcesPublishPlugin"
            ]
        )
    ]
    ...
)
```

For more information on how to use the Swift Package Manager, check out [this article](https://www.swiftbysundell.com/articles/managing-dependencies-using-the-swift-package-manager), or [its official documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

## Usage

First import PerFolderResourcesPublishPlugin wherever you’d like to use it:

```swift
import PerFolderResourcesPublishPlugin
```

The plugin can then be used within any publishing pipeline like this:

```swift
import PerFolderResourcesPublishPlugin

...
try DeliciousRecipes().publish(using: [
    ...
    .installPlugin(.copyPerDirectoryResources()),
    ...
])
```

This plugin can be installed at any point in the publishing process. It does not depend on or affect other steps.

If you're using a custom folder in the `addMarkdownFiles` publishing step, pass the same folder as the argument to this plugin:

```swift
import PerFolderResourcesPublishPlugin
...

try DeliciousRecipes().publish(using: [
    ...
    .addMarkdownFiles(at: myContentPath),
    ...
    .installPlugin(.copyPerDirectoryResources(at: myContentPath)),
    ...
])
```

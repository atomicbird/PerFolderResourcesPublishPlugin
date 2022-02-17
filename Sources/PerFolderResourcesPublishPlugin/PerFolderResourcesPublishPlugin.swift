import Foundation
import Publish
import Files

public extension Plugin {
    /// Copy non-Markdown files in the site folder to the same location in the published site. This may be useful in cases such as blog posts which include inline images in the same folder as the post. In this context "resources" means any file that's not Markdown or plain text.
    ///
    ///Install the plugin at any point in the publishing process. It does not depend on or affect other steps.
    ///
    /// This plugin currently depends on [a fork of Publish](https://github.com/atomicbird/publish) that adds a `gitignore`-ish option to skip files or folders by name. If this seems useful to you, please comment on the [pull request](https://github.com/JohnSundell/Publish/pull/121).
    ///
    /// - Parameters:
    ///   - contentPath: Location of the site content folder. Defaults to `Content`. Use the same location you use with the `addMarkdownFiles` step, if any.
    ///   - verbose: Optionally print information about copied files when the plugin runs.
    /// - Returns: Publish plugin.
    static func copyPerFolderResources(at contentPath: Path = "Content", verbose: Bool = false) -> Self {
        Plugin(name: "Copy per-folder resources") { context in
            let contentFolder = try context.folder(at: contentPath)
            for folder in contentFolder.subfolders.recursive {
                guard !context.site.shouldIgnore(name: folder.name) else {
                    if (verbose) { print("\tSkipping folder \(folder.name)")}
                    continue
                }
                for file in folder.files where !file.isMarkdown {
                    guard !context.site.shouldIgnore(name: file.name) else {
                        if (verbose) { print("\tSkipping file \(file.name)") }
                        continue
                    }
                    if (verbose) { print("\tCopying file \(file.path)") }
                    
                    // Get file path relative to contentFolder, e.g. "assets/image.png".
                    let filePath = try Path(file.path(relativeTo: context.folder(at: contentPath)))
                    // OK now get the source file path but relative to the project folder, e.g. "Content/assets/image.png".
                    let sourcePath = Path("\(contentPath)/\(filePath)")
                    // Destination is a directory relative to contentFolder/output folder, e.g. "assets"
                    let destinationFolderPath = Path((filePath.string as NSString).deletingLastPathComponent)

                    try context.copyFileToOutput(from: sourcePath, to: destinationFolderPath)
                }
            }
        }
    }
}

private extension File {
    static let markdownFileExtensions: Set<String> = [
        "md", "markdown", "txt", "text"
    ]

    var isMarkdown: Bool {
        self.extension.map(File.markdownFileExtensions.contains) ?? false
    }
}

// Optional macOS-only hosted rendering of the sample; not an iOS simulator test.
// Compile together with examples/swiftui/PaywallView.swift. See its README.
import AppKit
import SwiftUI

@main
struct PreviewExport {
    @MainActor static func main() throws {
        guard CommandLine.arguments.count == 2 else {
            print("Usage: render-swiftui /path/to/output.png")
            return
        }
        _ = NSApplication.shared
        let view = GrovePaywallDemo().frame(width: 390, height: 900)
        let host = NSHostingView(rootView: view)
        host.frame = CGRect(x: 0, y: 0, width: 390, height: 900)
        let window = NSWindow(contentRect: host.frame, styleMask: [.borderless], backing: .buffered, defer: false)
        window.contentView = host
        host.layoutSubtreeIfNeeded()
        RunLoop.current.run(until: Date().addingTimeInterval(0.5))
        host.displayIfNeeded()
        guard let bitmap = host.bitmapImageRepForCachingDisplay(in: host.bounds),
              let _ = window.contentView else {
            throw NSError(domain: "PreviewExport", code: 1, userInfo: [NSLocalizedDescriptionKey: "Cannot create hosted preview"])
        }
        host.cacheDisplay(in: host.bounds, to: bitmap)
        guard let png = bitmap.representation(using: .png, properties: [:]) else {
            throw NSError(domain: "PreviewExport", code: 2, userInfo: [NSLocalizedDescriptionKey: "Cannot encode PNG"])
        }
        try png.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
        print("Rendered hosted SwiftUI view on macOS. iOS rendering remains unverified.")
    }
}

#if canImport(UIKit)

import UIKit
public typealias NativeImage = UIImage

#elseif canImport(AppKit)

import AppKit
public typealias NativeImage = NSImage

#endif

import SwiftUI

extension Image {

    @MainActor
    public init(data: Data) {
        self = Image(nativeImage: NativeImage(data: data) ?? NativeImage())
    }

    @MainActor
    public init(nativeImage: NativeImage) {
#if canImport(UIKit)
        self = Image(uiImage: nativeImage)
#elseif canImport(AppKit)
        self = Image(nsImage: nativeImage)
#endif
    }
}

extension ImageRenderer {

    @MainActor
    public var nativeImage: NativeImage? {
#if canImport(UIKit)
        return uiImage
#elseif canImport(AppKit)
        return nsImage
#endif
    }
}

#if canImport(AppKit)
extension NSImage {

    @MainActor
    public func data() -> Data? {
        tiffRepresentation
    }
}
#endif

#if canImport(UIKit)
extension UIImage {

    @MainActor
    public convenience init(cgImage: CGImage, size: CGSize) {
        self.init(cgImage: cgImage)
    }

    @MainActor
    public func data() -> Data? {
        pngData()
    }
}
#endif

extension Data {

    @MainActor
    public init?(image: ImageResource) {
        guard let data = NativeImage(resource: image).data() else {
            return nil
        }

        self = data
    }
}

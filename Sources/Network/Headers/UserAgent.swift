import Foundation

#if canImport(UIKit)
import UIKit
#endif

public struct UserAgent: Sendable, Hashable, Equatable {
    let product: String
    let version: Version
    let device: String?
    let comment: String?

    public init(
        product: String = ProcessInfo.processInfo.processName,
        version: Version,
        comment: String? = nil
    ) {
        self.product = product
        self.version = version
        self.comment = comment
        self.device = nil
    }

#if canImport(UIKit)
    @MainActor public init(
        product: String = ProcessInfo.processInfo.processName,
        version: Version,
        device: UIDevice = UIDevice.current,
        comment: String? = nil
    ) {
        self.product = product
        self.version = version
        self.device = "\(device.model); \(device.systemName)/\(device.systemVersion)"
        self.comment = comment
    }
#endif
}

extension UserAgent: CustomStringConvertible {
    public var description: String {
        var value = "\(product)/\(version.description)"

        if let device {
            value += " (\(device))"
        }

        if let comment {
            value += " \(comment)"
        }

        return value
    }
}

extension UserAgent: HeaderConvertible {
    public func asHeaders() -> [Header] {
        [Header(name: "User-Agent", value: description)]
    }
}

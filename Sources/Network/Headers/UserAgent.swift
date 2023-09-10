import Foundation

#if os(iOS) || os(tvOS)
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

#if os(iOS) || os(tvOS)
        let model = UIDevice.current.model
        let os = UIDevice.current.systemName
        let osVersion = UIDevice.current.systemVersion

        device = "\(model); \(os)/\(osVersion)"
#else
        device = nil
#endif
    }
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

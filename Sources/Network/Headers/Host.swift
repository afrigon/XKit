import Foundation

public struct Host: Sendable, Hashable, Equatable {
    let value: String

    public init(value: String) {
        self.value = value
    }

    public init?(from url: URL) {
        guard let host = url.host(percentEncoded: false) else {
            return nil
        }

        value = host
    }
}

extension Host: CustomStringConvertible {
    public var description: String {
        value
    }
}

extension Host: HeaderConvertible {
    public func asHeaders() -> [Header] {
        [Header(name: "Host", value: description)]
    }
}

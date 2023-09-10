import Foundation

public struct ContentLength: Sendable, Hashable, Equatable {
    public let value: Int

    public init(_ value: Int) {
        self.value = value
    }

    public init<D: DataProtocol>(sizeOf data: D) {
        value = data.count
    }
}

extension ContentLength: CustomStringConvertible {
    public var description: String {
        "\(value)"
    }
}

extension ContentLength: HeaderConvertible {
    public func asHeaders() -> [Header] {
        [Header(name: "Content-Length", value: description)]
    }
}

public struct Accept {
    public let types: [ContentType]

    public init(_ type: ContentType) {
        self.types = [type]
    }

    public init(_ types: [ContentType]) {
        self.types = types
    }
}

extension Accept: CustomStringConvertible {
    public var description: String {
        types.map(\.description).joined(separator: ",")
    }
}

extension Accept: HeaderConvertible {
    public func asHeaders() -> [Header] {
        [Header(name: "Accept", value: description)]
    }
}

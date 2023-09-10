import Foundation

public protocol HeaderConvertible {
    func asHeaders() -> [Header]
}

public struct Header: Sendable, Codable {
    public let name: String
    public let value: String

    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }

    public init(data: (String, String)) {
        self.name = data.0
        self.value = data.1
    }
}

extension Header: CustomStringConvertible {
    public var description: String {
        "\(name): \(value)"
    }
}

extension Header: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name.lowercased())
        hasher.combine(value)
    }
}

extension Header: Equatable {
    public static func == (lhs: Header, rhs: Header) -> Bool {
        lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame && lhs.value == rhs.value
    }
}

extension Header: HeaderConvertible {
    public func asHeaders() -> [Header] {
        [self]
    }
}

extension Array: HeaderConvertible where Element == Header {
    public func asHeaders() -> [Header] {
        self
    }
}

@resultBuilder struct HeaderBuilder {
    static func buildBlock(_ components: HeaderConvertible...) -> HeaderConvertible {
        components.flatMap { $0.asHeaders() }
    }

    static func buildOptional(_ component: HeaderConvertible?) -> HeaderConvertible {
        component ?? []
    }

    static func buildEither(first component: HeaderConvertible) -> HeaderConvertible {
        component
    }

    static func buildEither(second component: HeaderConvertible) -> HeaderConvertible {
        component
    }

    static func buildArray(_ components: [HeaderConvertible]) -> HeaderConvertible {
        components.flatMap { $0.asHeaders() }
    }

    static func buildFinalResult(_ component: HeaderConvertible) -> [Header] {
        component.asHeaders()
    }
}

public struct Headers: Sendable, Hashable, Equatable, Codable {
    var values: [Header]

    public init(_ values: [Header] = []) {
        self.values = values
    }

    public init(@HeaderBuilder builder: () -> [Header]) {
        values = builder()
    }
}

extension Headers: CustomStringConvertible {
    public var description: String {
        values.map(\.description).sorted().joined(separator: "\n")
    }
}

extension Headers: Sequence {
    public typealias Iterator = Array<Header>.Iterator

    public func makeIterator() -> Iterator {
        values.makeIterator()
    }
}

extension Headers: Collection {
    public typealias Index = Array<Header>.Index

    public var startIndex: Index {
        values.startIndex
    }

    public var endIndex: Index {
        values.endIndex
    }

    public func index(after i: Index) -> Index {
        values.index(after: i)
    }

    public subscript(position: Index) -> Header {
        values[position]
    }
}

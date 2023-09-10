import Foundation

public struct Version: Sendable, Hashable, Equatable {
    public let year: Int
    public let month: Int
    public let day: Int
    public let revision: Int?

    public init(year: Int, month: Int, day: Int, revision: Int? = nil) {
        self.year = year
        self.month = month
        self.day = day
        self.revision = revision
    }

    public init(for date: Date = Date.now, revision: Int? = nil) {
        let calandar = Calendar(identifier: .gregorian)
        let components = calandar.dateComponents([.year, .month, .day], from: date)

        year = components.year ?? 0
        month = components.month ?? 0
        day = components.day ?? 0

        self.revision = revision
    }
}

extension Version: LosslessStringConvertible {
    public init?(_ description: String) {
        let components = description.split(separator: ".")
        let count = components.count

        guard count == 3 || count == 4 else {
            return nil
        }

        guard let year = Int(components[0]),
              let month = Int(components[1]),
              let day = Int(components[2]),
              year >= 0, (1...12).contains(month), (1...31).contains(day) else {
            return nil
        }

        self.year = year
        self.month = month
        self.day = day

        if count == 4 {
            guard let revision = Int(components[3]), revision >= 0 else {
                return nil
            }

            self.revision = revision
        } else {
            self.revision = nil
        }
    }

    public var description: String {
        let value = "\(year).\(month).\(day)"

        guard let revision else {
            return value
        }

        return "\(value).\(revision)"
    }
}

extension Version: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}

extension Version: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        guard let version = Version(value) else {
            let context: DecodingError.Context = .init(
                codingPath: container.codingPath,
                debugDescription: "Version needs to follow the format 2022.02.13"
            )

            throw DecodingError.typeMismatch(String.self, context)
        }

        self.year = version.year
        self.month = version.month
        self.day = version.day
        self.revision = version.revision
    }
}

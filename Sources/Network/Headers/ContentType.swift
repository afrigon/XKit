import Foundation

extension String {
    var isValidMultiPartBoundary: Bool {
        let special = "-='\\(\\)\\+\\,\\.\\/\\:\\?"

        return range(
            of: "^[\\w\(special)\\ ]{0,69}[\(special)]?$",
            options: .regularExpression
        ) != nil
    }
}

public struct MultiPartBoundary {
    public let value: String

    public init?(value: String) {
        guard value.isValidMultiPartBoundary else {
            return nil
        }

        self.value = value
    }

    var last: String {
        "--\(value)--"
    }
}

extension MultiPartBoundary: CustomStringConvertible {
    public var description: String {
        "--\(value)"
    }
}

public struct ContentType: Sendable, Hashable {
    private let type: String
    private let subtype: String
    private let parameters: [String: String]

    public init(type: String, subtype: String, parameters: [String: String] = [:]) {
        self.type = type
        self.subtype = subtype
        self.parameters = parameters
    }

    static func utf8(type: String, subtype: String) -> ContentType {
        .init(type: type, subtype: subtype, parameters: ["charset": "utf-8"])
    }

    public static let any = ContentType(type: "*", subtype: "*")

    // data
    public static let plaintext = ContentType.utf8(type: "text", subtype: "plain")
    public static let json = ContentType.utf8(type: "application", subtype: "json")
    public static let xml = ContentType.utf8(type: "application", subtype: "xml")
    public static let binary = ContentType(type: "application", subtype: "octet-stream")
    public static let zip = ContentType(type: "application", subtype: "zip")
    public static let tar = ContentType(type: "application", subtype: "x-tar")
    public static let gzip = ContentType(type: "application", subtype: "x-gzip")
    public static let bzip2 = ContentType(type: "application", subtype: "x-bzip2")

    // document
    public static let html = ContentType.utf8(type: "text", subtype: "html")
    public static let css = ContentType.utf8(type: "text", subtype: "css")
    public static let pdf = ContentType(type: "application", subtype: "pdf")

    // audio
    public static let audio = ContentType(type: "audio", subtype: "basic")
    public static let midi = ContentType(type: "audio", subtype: "x-midi")
    public static let mp3 = ContentType(type: "audio", subtype: "mpeg")
    public static let wave = ContentType(type: "audio", subtype: "wav")
    public static let ogg = ContentType(type: "audio", subtype: "vorbis")

    // image
    public static let gif = ContentType(type: "image", subtype: "gif")
    public static let jpeg = ContentType(type: "image", subtype: "jpeg")
    public static let png = ContentType(type: "image", subtype: "png")
    public static let svg = ContentType(type: "image", subtype: "svg+xml")

    // video
    public static let avi = ContentType(type: "video", subtype: "avi")
    public static let mpeg = ContentType(type: "video", subtype: "mpeg")

    // forms
    public static let urlEncodedForm = ContentType.utf8(type: "application", subtype: "x-www-form-urlencoded")

    static func formData(boundary: MultiPartBoundary? = nil) -> ContentType {
        guard let boundary else {
            return .init(type: "multipart", subtype: "form-data")
        }

        return .init(type: "multipart", subtype: "form-data", parameters: ["boundary": boundary.value])
    }
}

extension ContentType: Equatable {
    public static func == (lhs: ContentType, rhs: ContentType) -> Bool {
        guard lhs.type != "*" && rhs.type != "*" else {
            return true
        }

        guard lhs.type.caseInsensitiveCompare(rhs.type) == .orderedSame else {
            return false
        }

        return lhs.subtype == "*" || rhs.subtype == "*" ||
            lhs.subtype.caseInsensitiveCompare(rhs.subtype) == .orderedSame
    }
}

extension ContentType: CustomStringConvertible {
    public var description: String {
        parameters.reduce("\(type)/\(subtype)") { $0 + "; \($1.key)=\($1.value)" }
    }
}

extension ContentType: HeaderConvertible {
    public func asHeaders() -> [Header] {
        [Header(name: "Content-Type", value: description)]
    }
}

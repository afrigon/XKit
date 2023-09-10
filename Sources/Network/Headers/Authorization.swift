public enum Authorization: Sendable, Hashable, Equatable {
    case basic(username: String, password: String)
}

extension Authorization: CustomStringConvertible {
    public var description: String {
        switch self {
            case let .basic(username, password):
                guard let creds = "\(username):\(password)".data(using: .utf8)?.base64EncodedString() else {
                    return "Basic "
                }

                return "Basic \(creds)"
        }
    }
}

extension Authorization: HeaderConvertible {
    public func asHeaders() -> [Header] {
        [Header(name: "Authorization", value: description)]
    }
}

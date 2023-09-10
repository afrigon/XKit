public enum Method: String, Sendable, Hashable, Equatable, Codable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case options = "OPTIONS"
    case head = "HEAD"
    case trace = "TRACE"
}

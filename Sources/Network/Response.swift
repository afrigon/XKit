public struct Response<T: Sendable>: Sendable {
    public let status: Status
    public let headers: Headers
    public let body: T
}

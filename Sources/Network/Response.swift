public struct Response<T: Sendable & Hashable>: Sendable, Hashable {
    public let status: Status
    public let headers: Headers
    public let body: T
}

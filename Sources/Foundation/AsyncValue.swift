/// A wrapper type for data loaded asynchronously
public enum AsyncValue<Wrapped> {
    case loading
    case value(Wrapped)

    public init(_ value: Wrapped?) {
        guard let value else {
            self = .loading
            return
        }

        self = .value(value)
    }

    public var isLoading: Bool {
        switch self {
        case .loading:
            true
        case .value:
            false
        }
    }

    public var optional: Wrapped? {
        guard case let .value(value) = self else {
            return nil
        }

        return value
    }

    public func map<T>(_ fn: (Wrapped) -> T) -> AsyncValue<T> {
        if case let .value(value) = self {
            return .value(fn(value))
        }

        return .loading
    }
}

public struct RingBuffer<T> {
    public private(set) var buffer: [T]
    public private(set) var index: Int

    public init(repeating value: T, count: Int) {
        buffer = [T](repeating: value, count: count)
        index = 0
    }

    public mutating func push(_ value: T) {
        buffer[index] = value
        index = (index + 1) % buffer.count
    }

    public mutating func reset() {
        index = 0
    }
}


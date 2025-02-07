import SwiftUI

struct DebugColorGenerator: IteratorProtocol {
    @MainActor static var shared: DebugColorGenerator = .init()

    var current: Int = 0
    let values: [Color] = [
        .red,
        .green,
        .blue,
        .orange,
        .yellow,
        .purple,
        .pink,
        .cyan,
        .indigo,
        .mint,
        .teal
    ]

    typealias Element = Color

    mutating func next() -> Color? {
        current = (current + 1) % values.count

        return values[current]
    }
}

extension View {
    public func debug() -> some View {
        return background(DebugColorGenerator.shared.next() ?? .red)
    }
}

import SwiftUI

#if canImport(UIKit)
public typealias NativeColor = UIColor
#elseif canImport(AppKit)
public typealias NativeColor = NSColor
#endif

public extension NativeColor {
    private func get(color: NativeColor) -> NativeColor? {
        #if canImport(UIKit)
            color
        #elseif canImport(AppKit)
            color.usingColorSpace(.sRGB)
        #endif
    }

    func mix(with target: NativeColor, amount: CGFloat) -> NativeColor {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        guard let c1 = get(color: self), let c2 = get(color: target) else {
            return .white
        }

        c1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        c2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return .init(
            red: r1 * (1.0 - amount) + r2 * amount,
            green: g1 * (1.0 - amount) + g2 * amount,
            blue: b1 * (1.0 - amount) + b2 * amount,
            alpha: a1
        )
    }

    func lighter(by amount: CGFloat = 0.2) -> NativeColor {
        mix(with: .white, amount: amount)
    }

    func darker(by amount: CGFloat = 0.2) -> NativeColor {
        mix(with: .black, amount: amount)
    }
}

extension Color {
    public func lighter(by amount: CGFloat = 0.2) -> Color {
        .init(NativeColor(self).lighter(by: amount))
    }

    public func darker(by amount: CGFloat = 0.2) -> Color {
        .init(NativeColor(self).darker(by: amount))
    }
}

public struct DefaultOneStrategy<T: BinaryInteger & Decodable>: DefaultCodableStrategy {
    public static var defaultValue: T { 1 }
}

/// Decodes integers returning one instead of nil if applicable
///
/// `@DefaultOne` decodes Integers and returns one instead of nil if the Decoder is unable to decode the value.
public typealias DefaultOne<T> = DefaultCodable<DefaultOneStrategy<T>> where T: BinaryInteger & Decodable

public struct DefaultOneFloatStrategy<T: BinaryFloatingPoint & Decodable>: DefaultCodableStrategy {
    public static var defaultValue: T { 1.0 }
}

/// Decodes floating point returning one instead of nil if applicable
///
/// `@DefaultOneFloat` decodes Floating Points and returns one instead of nil if the Decoder is unable to decode the value.
public typealias DefaultOneFloat<T> = DefaultCodable<DefaultOneFloatStrategy<T>> where T: BinaryFloatingPoint & Decodable

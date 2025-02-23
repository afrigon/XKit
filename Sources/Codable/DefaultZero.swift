public struct DefaultZeroStrategy<T: BinaryInteger & Decodable>: DefaultCodableStrategy {
    public static var defaultValue: T { 0 }
}

/// Decodes Integers returning zero instead of nil if applicable
///
/// `@DefaultZero` decodes Integers and returns zero instead of nil if the Decoder is unable to decode the value.
public typealias DefaultZero<T> = DefaultCodable<DefaultZeroStrategy<T>> where T: BinaryInteger & Decodable

public struct DefaultZeroFloatStrategy<T: BinaryFloatingPoint & Decodable>: DefaultCodableStrategy {
    public static var defaultValue: T { 0.0 }
}

/// Decodes floating point returning zero instead of nil if applicable
///
/// `@DefaultZeroFloat` decodes Floatin Points and returns zero instead of nil if the Decoder is unable to decode the value.
public typealias DefaultZeroFloat<T> = DefaultCodable<DefaultZeroFloatStrategy<T>> where T: BinaryFloatingPoint & Decodable

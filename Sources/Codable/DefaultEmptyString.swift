public struct DefaultEmptyStringStrategy: DefaultCodableStrategy {
    public static var defaultValue: String { "" }
}

/// Decodes Strings returning an empty string instead of nil if applicable
///
/// `@DefaultEmptyString` decodes Strings and returns empty string instead of nil if the Decoder is unable to decode the value.
public typealias DefaultEmptyString = DefaultCodable<DefaultEmptyStringStrategy>

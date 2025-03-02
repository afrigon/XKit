public struct DefaultEmptyDictionaryStrategy<Key: Decodable & Hashable, Value: Decodable>: DefaultCodableStrategy {
    public static var defaultValue: [Key: Value] {
        [:]
    }
}

/// Decodes Dictionaries returning an empty dictionary instead of nil if applicable
///
/// `@DefaultEmptyDictionary` decodes Dictionaries and returns an empty dictionary instead of nil if the Decoder is unable
/// to decode the container.
public typealias DefaultEmptyDictionary<K, V> = DefaultCodable<DefaultEmptyDictionaryStrategy<K, V>> where K: Decodable & Hashable, V: Decodable

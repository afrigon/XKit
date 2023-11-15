 /// A wrapper type for data loaded asynchronously.
 /// Note: This is meant to be used for ghost loading placeholders
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

     /// Return true while the data is loading
     public var isLoading: Bool {
         switch self {
             case .loading:
                 true
             case .value:
                 false
         }
     }

     /// unwrap the data into an optional, return nil if data is still loading
     public var optional: Wrapped? {
         guard case let .value(value) = self else {
             return nil
         }

         return value
     }
 }

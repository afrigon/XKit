import SwiftUI

public enum StringResource {
    case string(String)
    case resource(LocalizedStringResource)
}

extension Text {
    public init(_ resource: StringResource) {
        switch resource {
            case .string(let string):
                self.init(verbatim: string)
            case .resource(let string):
                self.init(string)
        }
    }
}

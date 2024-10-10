import Foundation

extension URL {
    public func data() async -> Data? {
        try? await Request(self).data().body
    }

    public func json<T: Decodable>(_ type: T.Type) async -> T? {
        try? await Request(self).json(type).body
    }
}

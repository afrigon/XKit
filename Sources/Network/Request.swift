import Foundation

extension URLRequest {
    mutating func set(headers: Headers) {
        for header in headers {
            setValue(header.value, forHTTPHeaderField: header.name)
        }
    }
}

public struct Request {
    let urlRequest: URLRequest

    public init(
        method: Method = .get,
        _ url: URL,
        headers: Headers = Headers(),
        body: Data? = nil
    ) {
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue
        urlRequest.set(headers: headers)
        urlRequest.httpBody = body

        self.urlRequest = urlRequest
    }

    public init<T: Encodable>(
        method: Method = .post,
        _ url: URL,
        headers: Headers = Headers(),
        json body: T
    ) throws {
        let data = try JSONEncoder().encode(body)
        headers.append(ContentType.json)
        self.init(method: method, url, headers: headers, body: data)
    }

    private func execute<T>(parse: (Data) throws -> T) async throws -> Response<T> {
        let (data, res) = try await {
            do {
                return try await URLSession.shared.data(for: urlRequest)
            } catch let e {
                print(e)

                throw HTTPError.invalidRequest
            }
        }()

        guard let httpResponse = res as? HTTPURLResponse else {
            throw HTTPError.invalidResponse
        }

        let status = Status(code: httpResponse.statusCode)

        let headers = Headers(httpResponse.allHeaderFields.map { key, value in
            Header(name: String(describing: key), value: String(describing: value))
        })

        let body = try {
            do {
                return try parse(data)
            } catch let e {
                print(e)

                throw HTTPError.invalidData
            }
        }()

        return Response(status: status, headers: headers, body: body)
    }

    public func data() async throws -> Response<Data> {
        try await execute { $0 }
    }

    public func json<T: Decodable>() async throws -> Response<T> {
        try await execute { data in
            try JSONDecoder().decode(T.self, from: data)
        }
    }
}

extension Request: CustomStringConvertible {
    public var description: String {

        guard let method = urlRequest.httpMethod, let url = urlRequest.url?.absoluteString else {
            return "<could not describe request>"
        }

        return "\(method) \(url)"
    }
}

extension Request: CustomDebugStringConvertible {
    public var debugDescription: String {
        var value = description

        if let headers = urlRequest.allHTTPHeaderFields?.map(Header.init), !headers.isEmpty {
            value += "\n"
            value += Headers(headers).description
        }

        if let body = urlRequest.httpBody {
            value += "\n"
            value += "\n"

            if let string = String(data: body, encoding: .utf8) {
                value += string
            } else {
                value += "<body of size: \(body.count)>"
            }
        }

        return value
    }
}

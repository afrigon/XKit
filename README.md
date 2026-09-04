# XKit

Small utilities shared across Apple-platform projects — the pieces that get
rewritten in every app, collected once. Everything ships as a single `XKit`
library targeting iOS 18, macOS 15, macCatalyst 18, watchOS 10, tvOS 18 and
visionOS 2.

## Install

Add the package to a `Package.swift`:

```swift
.package(url: "https://github.com/afrigon/XKit.git", branch: "main")
```

```swift
.target(name: "App", dependencies: ["XKit"])
```

## What is in it

**Codable** — property wrappers that keep decoding alive when a field is
missing or the wrong shape. `@DefaultCodable` falls back to a strategy type;
`@DefaultEmptyArray`, `@DefaultEmptyDictionary`, `@DefaultEmptyString`,
`@DefaultTrue`, `@DefaultFalse`, `@DefaultZero` and `@DefaultOne` cover the
common cases, and `LosslessValue` decodes a value written as the wrong
primitive.

```swift
struct Account: Decodable {
    @DefaultFalse var verified: Bool
    @DefaultEmptyArray var tags: [String]
}
```

**Networking** — a typed layer over `URLRequest`. `Request` builds from a
method, URL, `Headers` and an optional body, encoding `Encodable` bodies
directly. Headers are types rather than strings: `Accept`, `Authorization`,
`ContentType`, `ContentLength`, `Host`, `UserAgent`. Responses carry a
`Status`, and failures surface as `HTTPError`.

```swift
let request = try Request(
    method: .post,
    url,
    headers: Headers {
        Authorization.bearer(token: token)
    },
    json: payload
)
```

`Headers` takes a result builder, so headers compose with `if` and `for` the
way a SwiftUI view body does. The `json:` initializer encodes the body and
adds `ContentType.json` itself.

**Foundation** — `AsyncValue` models data that is either loading or loaded,
with `map`, `isLoading` and `optional`. Alongside it: `Version` for semantic
versions, `StringResource`, `ContextInfo`, string padding and collection
helpers.

**Collections** — `RingBuffer`, a fixed-size buffer that overwrites oldest
first, `Codable` when its element is.

**UI** — `NativeImage` and `NativeColor` alias the right platform type so
shared code compiles everywhere, `ImageView` and `ImageSource` load images
into SwiftUI, and `View+Debug` adds inspection helpers.

## Development

```sh
mise run build     # swift build
mise run lint      # swiftlint, strict
mise run format    # swiftformat
```

Tooling is pinned in `mise.toml`; `mise install` fetches the Swift toolchain,
swiftlint and swiftformat at the versions the package is checked against.

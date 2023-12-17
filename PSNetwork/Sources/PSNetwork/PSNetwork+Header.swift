import Foundation

public extension PSNetwork {
    /// Represents a header for a network request.
    struct Header: Hashable {
        /// The key of the header.
        let key: String
        /// The value of the header.
        let value: String

        /// Initializes a new header with the specified key and value.
        /// - Parameters:
        ///   - key: The key of the header.
        ///   - value: The value of the header.
        public init(key: String, value: String) {
            self.key = key
            self.value = value
        }
    }
}

public extension PSNetwork.Header {
    /// Adds the header to the specified URLRequest.
    /// - Parameter request: The URLRequest to add the header to.
    func add(to request: inout URLRequest) {
        request.addValue(value, forHTTPHeaderField: key)
    }
}

/// Extension for PSNetwork.Header that provides convenience methods for creating common HTTP headers.
public extension PSNetwork.Header {
    
    /// Creates an "Accept-Language" header with the specified value.
    /// - Parameter value: The value of the header.
    /// - Returns: An instance of PSNetwork.Header with the "Accept-Language" key and the specified value.
    static func acceptLanguage(_ value: String) -> PSNetwork.Header {
        .init(key: "Accept-Language", value: value)
    }

    /// Creates an "Accept-Encoding" header with the specified value.
    /// - Parameter value: The value of the header.
    /// - Returns: An instance of PSNetwork.Header with the "Accept-Encoding" key and the specified value.
    static func acceptEncoding(_ value: String) -> PSNetwork.Header {
        .init(key: "Accept-Encoding", value: value)
    }

    /// Creates a "Host" header with the specified value.
    /// - Parameter value: The value of the header.
    /// - Returns: An instance of PSNetwork.Header with the "Host" key and the specified value.
    static func host(_ value: String) -> PSNetwork.Header {
        .init(key: "Host", value: value)
    }

    /// Creates an "Accept-Charset" header with the specified value.
    /// - Parameter value: The value of the header.
    /// - Returns: An instance of PSNetwork.Header with the "Accept-Charset" key and the specified value.
    static func acceptCharset(_ value: String) -> PSNetwork.Header {
        .init(key: "Accept-Charset", value: value)
    }

    /// Creates a "Cookie" header with the specified value.
    /// - Parameter value: The value of the header.
    /// - Returns: An instance of PSNetwork.Header with the "Cookie" key and the specified value.
    static func cookie(_ value: String) -> PSNetwork.Header {
        .init(key: "Cookie", value: value)
    }

    /// Creates a "Content-Type" header with the value "application/json".
    /// - Returns: An instance of PSNetwork.Header with the "Content-Type" key and the value "application/json".
    @discardableResult
    static func contentType() -> PSNetwork.Header {
        .init(key: "Content-Type", value: "application/json")
    }

    /// Creates a "Keep-Alive" header with the specified value.
    /// - Parameter value: The value of the header.
    /// - Returns: An instance of PSNetwork.Header with the "Keep-Alive" key and the specified value.
    static func keepAlive(_ value: String) -> PSNetwork.Header {
        .init(key: "Keep-Alive", value: value)
    }

    /// Creates a "Connection" header with the specified value.
    /// - Parameter value: The value of the header.
    /// - Returns: An instance of PSNetwork.Header with the "Connection" key and the specified value.
    static func connection(_ value: String) -> PSNetwork.Header {
        .init(key: "Connection", value: value)
    }

    /// Creates a "Cache-Control" header with the specified value.
    /// - Parameter value: The value of the header.
    /// - Returns: An instance of PSNetwork.Header with the "Cache-Control" key and the specified value.
    static func cacheControl(_ value: String) -> PSNetwork.Header {
        .init(key: "Cache-Control", value: value)
    }
}

extension Array where Element == PSNetwork.Header {
    var httpHeadersFields: [String: String] {
        var dict = [String: String]()
        forEach { dict[$0.key] = $0.value }
        return dict
    }
}

extension Array where Element == PSNetwork.Header {
    func add(to request: inout URLRequest) {
        forEach { $0.add(to: &request) }
    }
}

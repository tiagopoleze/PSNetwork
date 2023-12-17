import Foundation

public extension PSNetwork {
    struct Header: Hashable {
        let key: String
        let value: String

        public init(key: String, value: String) {
            self.key = key
            self.value = value
        }
    }
}

public extension PSNetwork.Header {
    func add(to request: inout URLRequest) {
        request.addValue(value, forHTTPHeaderField: key)
    }
}

public extension PSNetwork.Header {
    static func acceptLanguage(_ value: String) -> PSNetwork.Header {
        .init(key: "Accept-Language", value: value)
    }

    static func acceptEncoding(_ value: String) -> PSNetwork.Header {
        .init(key: "Accept-Encoding", value: value)
    }

    static func host(_ value: String) -> PSNetwork.Header {
        .init(key: "Host", value: value)
    }

    static func acceptCharset(_ value: String) -> PSNetwork.Header {
        .init(key: "Accept-Charset", value: value)
    }

    static func cookie(_ value: String) -> PSNetwork.Header {
        .init(key: "Cookie", value: value)
    }

    @discardableResult
    static func contentType() -> PSNetwork.Header {
        .init(key: "Content-Type", value: "application/json")
    }

    static func keepAlive(_ value: String) -> PSNetwork.Header {
        .init(key: "Keep-Alive", value: value)
    }

    static func connection(_ value: String) -> PSNetwork.Header {
        .init(key: "Connection", value: value)
    }

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

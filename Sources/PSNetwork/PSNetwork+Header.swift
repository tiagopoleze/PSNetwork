import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork {
    struct Header {
        let key: String
        let value: String

        public init(key: String, value: String) {
            self.key = key
            self.value = value
        }
    }
}

@available(iOS 13, macOS 10.15, *)
public extension Array where Element == PSNetwork.Header {
    var httpHeadersFields: [String: String] {
        var dict = [String: String]()
        forEach { dict[$0.key] = $0.value }
        return dict
    }
}

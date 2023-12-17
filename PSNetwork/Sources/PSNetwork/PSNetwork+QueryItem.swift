import Foundation

public extension PSNetwork {
    struct QueryItem {
        let name: String
        let value: String

        public init(name: String, value: String) {
            self.name = name
            self.value = value
        }
    }
}

@available(iOS 13, macOS 10.15, *)
internal extension Array where Element == PSNetwork.QueryItem {
    var urlQueryItems: [URLQueryItem] { map { .init(name: $0.name, value: $0.value) } }
}

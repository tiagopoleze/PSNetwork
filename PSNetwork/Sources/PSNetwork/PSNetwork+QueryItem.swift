import Foundation

public extension PSNetwork {
    /// Represents a query item used in PSNetwork requests.
    struct QueryItem {
        /// The name of the query item.
        let name: String
        /// The value of the query item.
        let value: String

        /// Initializes a new query item with the specified name and value.
        /// - Parameters:
        ///   - name: The name of the query item.
        ///   - value: The value of the query item.
        public init(name: String, value: String) {
            self.name = name
            self.value = value
        }
    }
}

internal extension Array where Element == PSNetwork.QueryItem {
    var urlQueryItems: [URLQueryItem] { map { .init(name: $0.name, value: $0.value) } }
}

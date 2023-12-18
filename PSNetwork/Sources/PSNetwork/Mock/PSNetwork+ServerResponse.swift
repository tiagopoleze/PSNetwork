import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
public extension PSNetwork.Mock {
    /// Represents a server response in the PSNetwork.Mock module.
    /// It contains information such as the status code, HTTP version, data, and headers.
    struct ServerResponse<T: Hashable>: Hashable {
        /// The status code of the server response.
        public let statusCode: PSNetwork.StatusCode
        /// The HTTP version of the server response.
        public let httpVersion: PSNetwork.HTTPVersion
        /// The data associated with the server response.
        public let data: T?
        /// The headers of the server response.
        public let headers: [PSNetwork.Header]

        /// Initializes a new instance of `ServerResponse`.
        /// - Parameters:
        ///   - statusCode: The status code of the server response.
        ///   - httpVersion: The HTTP version of the server response. Default value is `.onePointOne`.
        ///   - data: The data associated with the server response. Default value is `nil`.
        ///   - headers: The headers of the server response. Default value is an empty array.
        public init(
            statusCode: PSNetwork.StatusCode,
            httpVersion: PSNetwork.HTTPVersion = .onePointOne,
            data: T? = nil,
            headers: [PSNetwork.Header] = []
        ) {
            self.statusCode = statusCode
            self.httpVersion = httpVersion
            self.data = data
            self.headers = headers
        }
    }
}

import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
public extension PSNetwork.Mock {
    /// Represents a network exchange in the mock mode of PSNetwork.
    /// It contains the URL request, the server response, and any error that occurred during the exchange.
    struct NetworkExchange<T: Hashable>: Hashable {
        /// The URL request sent during the network exchange.
        public let urlRequest: URLRequest
        /// The server response received during the network exchange.
        public let response: ServerResponse<T>?
        /// The error that occurred during the network exchange, if any.
        public let error: PSNetwork.Error?
        
        /// The URL response generated from the server response.
        public var urlResponse: HTTPURLResponse? {
            guard let response = response else {
                return nil
            }

            return HTTPURLResponse(
                url: urlRequest.url!,
                statusCode: response.statusCode.rawValue,
                httpVersion: response.httpVersion.rawValue,
                headerFields: response.headers.httpHeadersFields
            )
        }

        /// Initializes a new network exchange with the specified parameters.
        /// - Parameters:
        ///   - urlRequest: The URL request sent during the network exchange.
        ///   - response: The server response received during the network exchange. Default is `nil`.
        ///   - error: The error that occurred during the network exchange. Default is `nil`.
        public init(
            urlRequest: URLRequest,
            response: ServerResponse<T>? = nil,
            error: PSNetwork.Error? = nil
        ) {
            self.urlRequest = urlRequest
            self.response = response
            self.error = error
        }
    }
}

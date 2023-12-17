import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
public extension PSNetwork.Mock {
    struct NetworkExchange<T: Hashable>: Hashable {
        public let urlRequest: URLRequest
        public let response: ServerResponse<T>?
        public let error: PSNetwork.Error?
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

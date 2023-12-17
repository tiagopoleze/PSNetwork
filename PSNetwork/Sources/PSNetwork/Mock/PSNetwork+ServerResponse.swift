import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
public extension PSNetwork.Mock {
    struct ServerResponse<T: Hashable>: Hashable {
        public let statusCode: PSNetwork.StatusCode
        public let httpVersion: PSNetwork.HTTPVersion
        public let data: T?
        public let headers: [PSNetwork.Header]

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

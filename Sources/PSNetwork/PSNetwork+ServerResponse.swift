import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork.Mock {
    struct ServerResponse<T: Hashable>: Hashable {
        let statusCode: PSNetwork.StatusCode
        let httpVersion: PSNetwork.HTTPVersion
        let data: T?
        let headers: [PSNetwork.Header]

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

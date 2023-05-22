import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork.Mock {
    struct ServerResponse: Hashable {
        let statusCode: PSNetwork.StatusCode
        let httpVersion: PSNetwork.HTTPVersion
        let data: Data?
        let headers: [String: String]

        public init(
            statusCode: PSNetwork.StatusCode,
            httpVersion: PSNetwork.HTTPVersion = .onePointOne,
            data: Data? = nil,
            headers: [String : String] = [:]
        ) {
            self.statusCode = statusCode
            self.httpVersion = httpVersion
            self.data = data
            self.headers = headers
        }
    }
}

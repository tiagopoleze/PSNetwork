import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork.Mock {
    struct NetworkExchange: Hashable {
        let urlRequest: URLRequest
        let response: ServerResponse?
        let error: PSNetwork.Error?
        var urlResponse: HTTPURLResponse? {
            guard let response = response else {
                return nil
            }

            return HTTPURLResponse(
                url: urlRequest.url!,
                statusCode: response.statusCode.rawValue,
                httpVersion: response.httpVersion.rawValue,
                headerFields: response.headers
            )
        }

        init(
            urlRequest: URLRequest,
            response: ServerResponse? = nil,
            error: PSNetwork.Error? = nil
        ) {
            self.urlRequest = urlRequest
            self.response = response
            self.error = error
        }
    }
}

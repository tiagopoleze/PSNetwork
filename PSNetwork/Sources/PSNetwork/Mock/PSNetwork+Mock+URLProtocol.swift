import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
extension PSNetwork.Mock {
    final class URLProtocol: Foundation.URLProtocol {
        static var mockRequests: Set<PSNetwork.Mock.NetworkExchange<Data>> = []
        static var delay = 0

        public override class func canInit(with request: URLRequest) -> Bool { true }
        public override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

        public override func startLoading() {
            defer { client?.urlProtocolDidFinishLoading(self) }
            sleep(UInt32(Self.delay))

            let foundedRequest = Self.mockRequests.first { [unowned self] in
                request.url?.path == $0.urlRequest.url?.path && request.httpMethod == $0.urlRequest.httpMethod
            }

            if let error = foundedRequest?.error {
                client?.urlProtocol(
                    self,
                    didFailWithError: error.urlError ?? NSError(domain: "MockURLProtocol", code: 0)
                )
                return
            }

            guard let mockExchange = foundedRequest else {
                client?.urlProtocol(self, didFailWithError: PSNetwork.Error.notFound)
                return
            }

            if let data = mockExchange.response?.data {
                client?.urlProtocol(self, didLoad: data)
            }

            guard let response = mockExchange.urlResponse else { return }

            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }

        public override func stopLoading() { }
    }
}

import Foundation

/**
 A subclass of `Foundation.URLProtocol` that provides mocking capabilities for network requests.

 - Note: This class is available on iOS 13, macOS 10.15, tvOS 15, and watchOS 7.

 The `URLProtocol` class intercepts and handles network requests made by the app.
 It can be used to mock network responses and simulate different network conditions during testing.

 The `PSNetwork.Mock.URLProtocol` class overrides the necessary methods to handle the mock requests.
 It checks if the request matches any of the mock requests stored in the `mockRequests` set. 
 If a match is found, it either returns the mock response or triggers an error. If no match is found, it returns a "not found" error.

 The class also includes a static `delay` property that can be used to simulate network delays by sleeping for a specified duration.

 To use this class, register it as a protocol class in the app's `URLSessionConfiguration`:

 ```
 URLSessionConfiguration.protocolClasses = [PSNetwork.Mock.URLProtocol.self]
 ```

 - Important: This class is intended for use in testing and debugging scenarios only. It should not be used in production code.
 */
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

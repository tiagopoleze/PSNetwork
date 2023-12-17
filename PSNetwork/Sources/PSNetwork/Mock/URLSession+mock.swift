import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
extension URLSession {
    static var mock: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [PSNetwork.Mock.URLProtocol.self]
        PSNetwork.Mock.URLProtocol.delay = 2
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return Foundation.URLSession(configuration: configuration)
    }
}

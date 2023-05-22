import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSRequest {
    func urlRequest() throws -> URLRequest {
        guard let endpoint = endpoint else {
            throw PSNetwork.Error.urlRequest
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.stringValue
        request.timeoutInterval = timeout
        request.cachePolicy = cachePolicy
        request.allHTTPHeaderFields = headers.httpHeadersFields
        addAuthorizationHeader(to: &request)
        if let body = try method.body(dataEncoder: encoder) {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        return request
    }
}

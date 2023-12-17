import Foundation

public extension PSRequest {
    /// Converts a `PSRequest` object into a `URLRequest` object.
    /// - Throws: `PSNetwork.Error.urlRequest` if the `endpoint` is nil.
    /// - Returns: The converted `URLRequest` object.
    func urlRequest() throws -> URLRequest {
        guard let endpoint = endpoint else {
            throw PSNetwork.Error.urlRequest
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = Self.method.stringValue
        request.timeoutInterval = timeout
        request.cachePolicy = cachePolicy
        headers.add(to: &request)
        authorizationType.addAuthorization(to: &request)
        if let bodyParameter, let body = try? encoder.encode(bodyParameter) {
            PSNetwork.Header.contentType().add(to: &request)
            request.httpBody = body
        }
        return request
    }
}

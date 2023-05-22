import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSRequest {
    func addAuthorizationHeader(to request: inout URLRequest) {
        switch authorizationType.header {
        case nil:
            break
        case let .some(httpHeader):
            request.addValue(httpHeader.value, forHTTPHeaderField: httpHeader.key)
        }
    }
}

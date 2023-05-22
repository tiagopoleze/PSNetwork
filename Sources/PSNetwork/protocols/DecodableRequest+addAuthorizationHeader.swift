import Foundation

extension DecodableRequest {
    func addAuthorizationHeader(to request: inout URLRequest) {
        switch authorizationType.header {
        case nil:
            break
        case let .some(httpHeader):
            request.addValue(httpHeader.value, forHTTPHeaderField: httpHeader.key)
        }
    }
}

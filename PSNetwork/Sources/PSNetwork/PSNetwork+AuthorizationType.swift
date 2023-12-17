import Foundation

public extension PSNetwork {
    enum AuthorizationType {
        case none
        case header(PSNetwork.Header)
        case bearer(String)

        func addAuthorization(to request: inout URLRequest) {
            switch self {
            case .none:
                break
            case let .header(header):
                request.addValue(header.value, forHTTPHeaderField: header.key)
            case let .bearer(token):
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
    }
}

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork {
    enum AuthorizationType {
        case none
        case header(PSNetwork.Header)
        case bearer(String)

        var header: PSNetwork.Header? {
            switch self {
            case .none:
                return nil
            case let .header(header):
                return header
            case let .bearer(token):
                return PSNetwork.Header(key: "Authorization", value: "Bearer \(token)")
            }
        }
    }
}

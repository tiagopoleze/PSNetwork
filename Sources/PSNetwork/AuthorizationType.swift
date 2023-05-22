public enum AuthorizationType {
    case none
    case header(HTTPHeader)
    case bearer(String)
}

extension AuthorizationType {
    var header: HTTPHeader? {
        switch self {
        case .none:
            return nil
        case let .header(header):
            return header
        case let .bearer(token):
            return HTTPHeader(key: "Authorization", value: "Bearer \(token)")
        }
    }
}

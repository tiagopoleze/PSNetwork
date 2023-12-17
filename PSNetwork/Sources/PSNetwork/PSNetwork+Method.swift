import Foundation

public extension PSNetwork {
    enum Method {
        case get
        case post
        case put
        case patch
        case delete

        internal var stringValue: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .patch:
                return "PATCH"
            case .delete:
                return "DELETE"
            }
        }
    }
}

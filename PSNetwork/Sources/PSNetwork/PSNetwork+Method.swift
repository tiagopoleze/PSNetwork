import Foundation

public extension PSNetwork {
    /// Enum that represents the HTTP methods used in PSNetwork.
    enum Method {
        /// - get: The GET method.
        case get
        /// - post: The POST method.
        case post
        /// - put: The PUT method.
        case put
        /// - patch: The PATCH method.
        case patch
        /// - delete: The DELETE method.
        case delete

        /// Returns the string representation of the HTTP method.
        var stringValue: String {
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

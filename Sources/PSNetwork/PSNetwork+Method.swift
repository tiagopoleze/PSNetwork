import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork {
    enum Method {
        case get
        case post(body: Encodable)
        case put(body: Encodable)
        case patch(body: Encodable)
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

        internal func body(dataEncoder: DataEncoder) throws -> Data? {
            switch self {
            case .post(let body):
                return try dataEncoder.encode(body)
            case .put(let body):
                return try dataEncoder.encode(body)
            case .patch(let body):
                return try dataEncoder.encode(body)
            case .delete, .get:
                return nil
            }
        }
    }
}

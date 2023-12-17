import Foundation

public protocol URLRequestConvertible {
    func urlRequest() throws -> URLRequest
}

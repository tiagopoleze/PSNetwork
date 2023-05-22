import Foundation

protocol URLRequestConvertible {
    func urlRequest() throws -> URLRequest
}

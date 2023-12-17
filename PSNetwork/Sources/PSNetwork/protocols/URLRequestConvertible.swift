import Foundation

/// A protocol that defines a convertible type to URLRequest.
public protocol URLRequestConvertible {
    
    /// Converts the conforming type to a URLRequest.
    ///
    /// - Returns: A URLRequest instance.
    /// - Throws: An error if the conversion fails.
    func urlRequest() throws -> URLRequest
}

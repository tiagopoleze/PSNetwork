import Foundation

/// A protocol that defines the requirements for encoding data.
public protocol DataEncoder {
    
    /// Encodes a value of a generic type into data.
    /// - Parameter value: The value to be encoded.
    /// - Returns: The encoded data.
    /// - Throws: An error if the encoding process fails.
    func encode<T>(_ value: T) throws -> Data where T: Encodable
}

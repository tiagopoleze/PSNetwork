import Foundation

/// A protocol for decoding data into a specific type.
public protocol DataDecoder {
    
    /// Decodes the specified type from the given data.
    /// - Parameters:
    ///   - type: The type to decode.
    ///   - data: The data to decode from.
    /// - Returns: The decoded value of the specified type.
    /// - Throws: An error if the decoding process fails.
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

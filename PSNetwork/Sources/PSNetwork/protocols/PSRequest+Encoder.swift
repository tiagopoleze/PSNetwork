import Foundation

/// Extension for `PSRequest` when the `Encoder` is of type `JSONEncoder`.
public extension PSRequest where Encoder: JSONEncoder {
    
    /// Returns a JSONEncoder instance with the key encoding strategy set to `.convertToSnakeCase`.
    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}

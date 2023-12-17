import Foundation

/// Extension for `PSRequest` protocol when the associated type `Decoder` is `JSONDecoder`.
public extension PSRequest where Decoder: JSONDecoder {
    
    /// The JSON decoder used for decoding the response.
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

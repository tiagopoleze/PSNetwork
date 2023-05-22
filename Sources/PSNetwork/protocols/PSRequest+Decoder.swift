import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSRequest where Decoder: JSONDecoder {
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSRequest where Encoder: JSONEncoder {
    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}

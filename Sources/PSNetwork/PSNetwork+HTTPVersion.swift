import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork {
    enum HTTPVersion: String {
        case onePointOne = "HTTP/1.1"
        case twoPointZero = "HTTP/2.0"
    }
}

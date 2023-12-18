import Foundation

/// Extension for PSNetwork that defines the supported HTTP versions.
public extension PSNetwork {
    /// Enum representing the HTTP versions.
    enum HTTPVersion: String {
        /// HTTP version 1.1
        case onePointOne = "HTTP/1.1"
        
        /// HTTP version 2.0
        case twoPointZero = "HTTP/2.0"
    }
}

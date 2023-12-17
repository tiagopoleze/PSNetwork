import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
extension PSRequest {
    var endpoint: URL? {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.port = port
        components.host = host
        if !Self.path.isEmpty { components.path = Self.path.componentPath }
        if !queryItems.isEmpty { components.queryItems = queryItems.urlQueryItems }
        return components.url
    }
}

private extension Array where Element == String {
    var componentPath: String {
        "/" + self.joined(separator: "/")
    }
}

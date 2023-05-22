import Foundation

extension DecodableRequest {
    var endpoint: URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.port = port
        components.host = host
        if !path.isEmpty { components.path = "/" + path.joined(separator: "/") }
        if !queryItems.isEmpty { components.queryItems = queryItems.urlQueryItems }
        return components.url!
    }
}

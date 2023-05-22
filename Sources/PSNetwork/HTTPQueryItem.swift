import Foundation

public struct HTTPQueryItem {
    let name: String
    let value: String

    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

extension Array where Element == HTTPQueryItem {
    var urlQueryItems: [URLQueryItem] { map { .init(name: $0.name, value: $0.value) } }
}

import Foundation

public struct HTTPHeader {
    let key: String
    let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

extension Array where Element == HTTPHeader {
    var httpHeadersFields: [String: String] {
        var dict = [String: String]()
        forEach { dict[$0.key] = $0.value }
        return dict
    }
}

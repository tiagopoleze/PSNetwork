import Vapor

extension Array where Element == String {
    var pathComponent: [PathComponent] {
        map { PathComponent(stringLiteral: $0) }
    }
}

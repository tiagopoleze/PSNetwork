import Foundation

protocol Between {
    associatedtype Number: Numeric
    func between(_ initial: Number, and final: Number) -> Bool
}

extension Int: Between {
    func between(_ initial: Int, and final: Int) -> Bool {
        return (initial...final).contains(self)
    }
}

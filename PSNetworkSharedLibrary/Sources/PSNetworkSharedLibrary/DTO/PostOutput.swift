import Foundation

public struct PostOutput: Codable {
    public let id: String
    public let name: String

    public init(id: String, name: String) {
        self.name = name
        self.id = id
    }
}

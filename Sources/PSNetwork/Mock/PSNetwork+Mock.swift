@available(iOS 13, macOS 10.15, *)
public extension PSNetwork {
    struct Mock {
        static var Manager: NetworkManager = .init(using: .mock)
    }
}

/// Extension for mocking PSNetwork functionality.
public extension PSNetwork {
    /// Mock implementation for PSNetwork.
    struct Mock {
        /// The mock network manager instance.
        static var Manager: NetworkManager = .init(using: .mock)
    }
}

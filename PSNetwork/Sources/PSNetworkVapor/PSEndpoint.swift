import Vapor

/// A protocol that defines the requirements for registering an endpoint with routes.
public protocol PSEndpoint {
    /// Registers the endpoint with the provided routes builder.
    ///
    /// - Parameter routes: The routes builder to register the endpoint with.
    static func register(with routes: RoutesBuilder)
}

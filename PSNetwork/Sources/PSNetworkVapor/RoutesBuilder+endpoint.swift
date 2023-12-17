import PSNetwork
import Vapor

/// Extension for `RoutesBuilder` to add an endpoint for a specific `PSRequest` type.
public extension RoutesBuilder {
    /// Adds an endpoint to the routes builder.
    /// - Parameters:
    ///   - endpoint: The type of `PSRequest` associated with the endpoint.
    ///   - closure: The closure that handles the request and returns the response model.
    /// - Returns: A `Vapor.Route` object representing the added endpoint.
    @discardableResult
    func endpoint<T: PSRequest>(
        _ endpoint: T.Type,
        use closure: @escaping (Vapor.Request, T.BodyParameter?) async throws -> T.ResponseModel
    ) -> Vapor.Route where T.ResponseModel: Vapor.AsyncResponseEncodable {
        return self.on(endpoint.method.nio, endpoint.path.pathComponent) { request async throws -> T.ResponseModel in
            if let content = try? request.content.decode(endpoint.BodyParameter) {
                return try await closure(request, content)
            }
            return try await closure(request, nil)
        }
    }
}

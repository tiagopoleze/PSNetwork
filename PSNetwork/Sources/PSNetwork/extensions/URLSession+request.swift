import Foundation

@available(iOS 11, macOS 10.13, tvOS 11, watchOS 3, *)
public extension URLSession {
    /// A convenience extension for URLSession that provides a method to fetch data from a URLRequest asynchronously.
    /// - Parameter request: The URLRequest to fetch data from.
    /// - Returns: A tuple containing the fetched data and the URLResponse.
    /// - Throws: An error if the data fetching fails or if the server response is invalid.
    /// - Note: This method is available on iOS 11+, macOS 10.13+, tvOS 11+, and watchOS 3+.
    /// - Warning: This method is deprecated in iOS 15 and macOS 12. It is recommended to use the `data(for:)` method instead.
    @available(iOS, deprecated: 15, message: "Should use `data(for:)` instead")
    @available(macOS, deprecated: 12, message: "Should use `data(for:)` instead")
    func data(from request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation({ continuation in
            let task = dataTask(with: request) { data, response, error in
                if let error { return continuation.resume(throwing: error) }
                guard let data, let response else { return continuation.resume(throwing: URLError(.badServerResponse)) }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        })
    }
}

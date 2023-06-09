import Foundation

@available(iOS 13, macOS 10.15, *)
extension URLSession {
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

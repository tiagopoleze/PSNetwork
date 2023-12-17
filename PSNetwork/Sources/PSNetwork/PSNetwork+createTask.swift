import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
extension PSNetwork {
    static func createTask(
        _ priority: TaskPriority,
        session: URLSession,
        request: URLRequestConvertible,
        delegate: URLSessionTaskDelegate?
    ) -> Task<(Data, URLResponse), Swift.Error> {
        return Task(priority: priority) {
            let request = try request.urlRequest()
            if #available(iOS 15, macOS 12.0, *) {
                return try await session.data(for: request, delegate: delegate)
            } else {
                return try await session.data(from: request)
            }
        }
    }
}

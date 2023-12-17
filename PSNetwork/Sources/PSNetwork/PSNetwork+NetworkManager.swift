import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
public extension PSNetwork {
    class NetworkManager: ObservableObject {
        @Published private(set) var networkMonitor: PSNetwork.NetworkMonitor
        private let session: URLSession

        public init(
            allowsExpensiveNetworkAccess: Bool = false,
            allowsConstrainedNetworkAccess: Bool = false,
            waitsForConnectivity: Bool = true,
            urlCache: URLCache? = .shared,
            requestCachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy
        ) {
            self.networkMonitor = PSNetwork.NetworkMonitor()
            let configuration = URLSessionConfiguration.default
            configuration.allowsExpensiveNetworkAccess = allowsExpensiveNetworkAccess
            configuration.allowsConstrainedNetworkAccess = allowsConstrainedNetworkAccess
            configuration.waitsForConnectivity = waitsForConnectivity
            configuration.urlCache = urlCache
            configuration.requestCachePolicy = requestCachePolicy
            self.session = URLSession(configuration: configuration)
        }

        internal init(using session: URLSession) {
            self.networkMonitor = PSNetwork.NetworkMonitor()
            self.session = session
        }

        public func request<R: PSRequest>(
            _ request: R,
            priority: TaskPriority = .medium,
            delegate: URLSessionTaskDelegate? = nil
        ) async throws -> R.ResponseModel {
            let data: Data
            let response: URLResponse
            let responseModel: R.ResponseModel

            let task = PSNetwork.createTask(
                priority,
                session: session,
                request: request,
                delegate: delegate
            )

            do {
                (data, response) = try await task.value
            } catch {
                throw PSNetwork.generic(error)
            }

            if let httpError = PSNetwork.httpResponse(response) {
                throw httpError
            }

            do {
                responseModel = try request.decoder.decode(R.ResponseModel.self, from: data)
            } catch {
                throw PSNetwork.Error.failedToDecode(data)
            }

            return responseModel
        }
    }
}

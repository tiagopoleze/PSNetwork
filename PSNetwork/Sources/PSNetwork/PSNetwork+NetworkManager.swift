import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
public extension PSNetwork {
    /**
         A class that manages network requests using URLSession.
         
         This class provides a convenient way to configure and manage network requests using URLSession. 
         It allows customization of network access permissions, caching policies, and connectivity behavior.
         */
        class Manager: ObservableObject {
            @Published private(set) var monitor: PSNetwork.Monitor
            private let session: URLSession

            /**
             Initializes a new instance of the Manager class.
             
             - Parameters:
                - allowsExpensiveNetworkAccess: A boolean value indicating whether the manager allows expensive network access. Default is `false`.
                - allowsConstrainedNetworkAccess: A boolean value indicating whether the manager allows constrained network access. Default is `false`.
                - waitsForConnectivity: A boolean value indicating whether the manager waits for connectivity before making network requests. Default is `true`.
                - urlCache: An optional URLCache object to be used for caching network responses. Default is `.shared`.
                - requestCachePolicy: The cache policy to be used for network requests. Default is `.useProtocolCachePolicy`.
             */
            public init(
                allowsExpensiveNetworkAccess: Bool = false,
                allowsConstrainedNetworkAccess: Bool = false,
                waitsForConnectivity: Bool = true,
                urlCache: URLCache? = .shared,
                requestCachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy
            ) {
                self.monitor = PSNetwork.Monitor()
                let configuration = URLSessionConfiguration.default
                configuration.allowsExpensiveNetworkAccess = allowsExpensiveNetworkAccess
                configuration.allowsConstrainedNetworkAccess = allowsConstrainedNetworkAccess
                configuration.waitsForConnectivity = waitsForConnectivity
                configuration.urlCache = urlCache
                configuration.requestCachePolicy = requestCachePolicy
                self.session = URLSession(configuration: configuration)
            }

        init(using session: URLSession) {
            self.monitor = PSNetwork.Monitor()
            self.session = session
        }

        /// Sends a network request using the PSNetwork library.
        /// - Parameters:
        ///     - request: The request object conforming to the PSRequest protocol.
        ///     - priority: The priority of the network request. Defaults to `.medium`.
        ///     - delegate: An optional URLSessionTaskDelegate to handle task-specific behavior.
        /// - Returns: The response model of the network request.
        /// - Throws: An error if the network request fails or if there is an error decoding the response data.
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

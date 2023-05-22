import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork {
    class NetworkManager: ObservableObject {
        @Published private(set) var networkMonitor: PSNetwork.NetworkMonitor
        private let session: URLSession
        private var tasks: [Task<(Data, URLResponse), Swift.Error>] = []

        init(
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

        deinit {
            tasks.forEach { $0.cancel() }
        }

        func request<R: PSRequest>(_ request: R, priority: TaskPriority = .medium) async throws -> R.ResponseModel {
            let data: Data
            let response: URLResponse
            let responseModel: R.ResponseModel

            defer { tasks.removeAll(where: { $0 == task }) }

            let task = Task(priority: priority) {
                if #available(iOS 15, macOS 12.0, *) {
                    return try await session.data(for: request.urlRequest())
                } else {
                    return try await session.data(from: request.urlRequest())
                }
            }

            tasks.append(task)

            do {
                (data, response) = try await task.value
            } catch {
                guard let err = error as? URLError else {
                    throw PSNetwork.Error.generic(error)
                }
                if err.code.rawValue == NSURLErrorNotConnectedToInternet {
                    throw PSNetwork.Error.noConnectedToInternet
                }

                if err.code.rawValue == NSURLErrorTimedOut {
                    throw PSNetwork.Error.requestTimeout
                }
                throw PSNetwork.Error.urlError(err)
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                throw PSNetwork.Error.serverResponseNotValid
            }

            if httpResponse.statusCode.between(400, and: 499) {
                if httpResponse.statusCode == 403 {
                    throw PSNetwork.Error.forbidden
                }

                if httpResponse.statusCode == 404 {
                    throw PSNetwork.Error.notFound
                }

                throw PSNetwork.Error.clientError(httpResponse.statusCode)
            }

            if httpResponse.statusCode.between(500, and: 599) {
                throw PSNetwork.Error.serverError(httpResponse.statusCode)
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

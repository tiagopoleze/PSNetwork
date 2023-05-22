import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork {
    class NetworkManager: ObservableObject {
        @Published private(set) var networkMonitor: PSNetwork.NetworkMonitor
        private let session: URLSession

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

        func request<R: PSRequest>(
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

@available(iOS 13, macOS 10.15, *)
extension PSNetwork {
    static func generic(_ error: Swift.Error) -> PSNetwork.Error {
        guard let err = error as? URLError else {
            return PSNetwork.Error.generic(error)
        }
        if err.code.rawValue == NSURLErrorNotConnectedToInternet {
            return PSNetwork.Error.noConnectedToInternet
        }

        if err.code.rawValue == NSURLErrorTimedOut {
            return PSNetwork.Error.requestTimeout
        }
        return PSNetwork.Error.urlError(err)
    }

    static func httpResponse(_ response: URLResponse) -> PSNetwork.Error? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return PSNetwork.Error.serverResponseNotValid
        }

        if httpResponse.statusCode.between(400, and: 499) {
            if httpResponse.statusCode == 403 {
                return PSNetwork.Error.forbidden
            }

            if httpResponse.statusCode == 404 {
                return PSNetwork.Error.notFound
            }

            return PSNetwork.Error.clientError(httpResponse.statusCode)
        }

        if httpResponse.statusCode.between(500, and: 599) {
            return PSNetwork.Error.serverError(httpResponse.statusCode)
        }

        return nil
    }

    static func createTask(
        _ priority: TaskPriority,
        session: URLSession,
        request: URLRequestConvertible,
        delegate: URLSessionTaskDelegate?
    ) -> Task<(Data, URLResponse), Swift.Error> {
        return Task(priority: priority) {
            if #available(iOS 15, macOS 12.0, *) {
                return try await session.data(for: request.urlRequest(), delegate: delegate)
            } else {
                return try await session.data(from: request.urlRequest())
            }
        }
    }
}

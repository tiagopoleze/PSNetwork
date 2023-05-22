import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork {
    class NetworkManager {
        internal let session: URLSession

        init(using session: URLSession) {
            self.session = session
        }

        func request<R: PSRequest>(_ request: R) async throws -> R.ResponseModel {
            let data: Data
            let response: URLResponse
            let responseModel: R.ResponseModel

            do {
                if #available(iOS 15, macOS 12.0, *) {
                    (data, response) = try await session.data(for: request.urlRequest())
                } else {
                    (data, response) = try await session.data(from: request.urlRequest())
                }
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

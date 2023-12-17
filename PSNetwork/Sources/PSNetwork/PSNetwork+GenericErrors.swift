import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
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
            if httpResponse.statusCode == PSNetwork.StatusCode.forbidden.rawValue {
                return PSNetwork.Error.forbidden
            }

            if httpResponse.statusCode == PSNetwork.StatusCode.notFound.rawValue {
                return PSNetwork.Error.notFound
            }

            return PSNetwork.Error.clientError(httpResponse.statusCode)
        }

        if httpResponse.statusCode.between(500, and: 599) {
            return PSNetwork.Error.serverError(httpResponse.statusCode)
        }

        return nil
    }
}

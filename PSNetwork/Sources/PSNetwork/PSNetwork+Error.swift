import Foundation

/// Extension for handling PSNetwork errors.
public extension PSNetwork {
    /// Enumeration representing different types of errors that can occur in PSNetwork.
    enum Error: Swift.Error, Hashable, Equatable {
        /// A generic error that wraps another Swift error.
        case generic(Swift.Error)
        /// Error indicating that there is no internet connection.
        case noConnectedToInternet
        /// Error indicating that the request has timed out.
        case requestTimeout
        /// Error indicating a URL-related error.
        case urlError(URLError)
        /// Error indicating that the server response is not valid.
        case serverResponseNotValid
        /// Error indicating that the request is forbidden.
        case forbidden
        /// Error indicating that the requested resource was not found.
        case notFound
        /// Error indicating a client error with the specified status code.
        case clientError(Int)
        /// Error indicating a server error with the specified status code.
        case serverError(Int)
        /// Error indicating that the data failed to decode.
        case failedToDecode(Data)
        /// Error indicating that the data failed to encode.
        case failedToEncode
        /// Error indicating that there is no internet connection.
        case notConnectedToInternet
        /// Error indicating that the host could not be found.
        case hostNotFound
        /// Error indicating that there is no URL error.
        case noURLError
        /// Error indicating an issue with the URL request.
        case urlRequest
        
        internal var urlError: URLError? {
            switch self {
            case .forbidden:
                return URLError(.clientCertificateRejected)
            case .notFound:
                return URLError(.resourceUnavailable)
            case .notConnectedToInternet:
                return URLError(.notConnectedToInternet)
            case .requestTimeout:
                return URLError(.timedOut)
            case .hostNotFound:
                return URLError(.cannotFindHost)
            case let .urlError(error):
                return error
            case .serverResponseNotValid:
                return URLError.init(.badServerResponse)
            default:
                return nil
            }
        }

        /// Hashes the error instance into the specified hasher.
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self)
        }

        /// Checks if two PSNetwork errors are equal.
        public static func == (lhs: PSNetwork.Error, rhs: PSNetwork.Error) -> Bool {
            lhs.localizedDescription == rhs.localizedDescription
        }
    }
}

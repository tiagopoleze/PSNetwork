import Foundation

public extension PSNetwork {
    enum Error: Swift.Error, Hashable, Equatable {
        case generic(Swift.Error)
        case noConnectedToInternet
        case requestTimeout
        case urlError(URLError)
        case serverResponseNotValid
        case forbidden
        case notFound
        case clientError(Int)
        case serverError(Int)
        case failedToDecode(Data)
        case failedToEncode
        case notConnectedToInternet
        case hostNotFound
        case noURLError
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

        public func hash(into hasher: inout Hasher) {
            hasher.combine(self)
        }

        public static func == (lhs: PSNetwork.Error, rhs: PSNetwork.Error) -> Bool {
            lhs.localizedDescription == rhs.localizedDescription
        }
    }
}

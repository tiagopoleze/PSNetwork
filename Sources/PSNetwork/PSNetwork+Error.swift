import Foundation

@available(iOS 13, macOS 10.15, *)
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
        case routeNotFound
        case hostNotFound
        case noURLError

        var urlError: URLError? {
            switch self {
            case .notConnectedToInternet:
                return URLError(.notConnectedToInternet)
            case .requestTimeout:
                return URLError(.timedOut)
            case .routeNotFound:
                return URLError(.resourceUnavailable)
            case .hostNotFound:
                return URLError(.cannotFindHost)
            case let .urlError(error):
                return error
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

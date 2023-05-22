import Foundation

// MARK: Example
//struct SomeRequest: DecodableRequest {
//    typealias ResponseModel = EmptyResponseModel
//
//    var authorizationType: AuthorizationType = .none
//    var host: String = "example.com"
//    var path: [String] = []
//    var method: HTTPMethod = .get
//    var scheme: NetworkScheme = .http
//    var port: Int? = nil
//    var headers: [String : String] = ["someKey": "someValue"]
//    var queryItems: [String : String] = [:]
//    var httpBody: EmptyResponseModel = .value
//    var timeout: TimeInterval = 20
//    var encoder: JSONEncoder = .init()
//    var decoder: JSONDecoder = .init()
//}

//extension DecodableRequest {
//    var method: HTTPMethod { .get }
//    var scheme: NetworkScheme { .https }
//    var host: String { "api.domain.com" }
//    var port: Int? { nil }
//    var headers: [String : String] { ["someKey": "someValue"] }
//    var queryItems: [String : String] { [:] }
//    var httpBody: EmptyResponseModel { .value }
//    var timeout: TimeInterval { 20 }
//}

// MARK: New example
//struct OtherRequest: DecodableRequest {
//    typealias ResponseModel = EmptyResponseModel
//
//    var authorizationType: AuthorizationType = .none
//    var path: [String] = []

//    var authorizationType: Network.AuthorizationType = .none
//    var path: Network.URL.Path = []
//}

extension DecodableRequest {
    func urlRequest() throws -> URLRequest {
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeout
        request.allHTTPHeaderFields = headers.httpHeadersFields
        addAuthorizationHeader(to: &request)

        if type(of: httpBody) != EmptyResponseModel.self {
            do {
                if encoder is JSONEncoder {
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                request.httpBody = try encoder.encode(httpBody)
            } catch {
                // TODO: this
//                throw Network.Error.failedToEncode
            }
        }
        return request
    }
}

//let someRequest = SomeRequest().urlRequest()

@available(iOS 13, macOS 10.15, *)
class NetworkManager {
    internal let session: URLSession

    init(using session: URLSession) {
        self.session = session
    }

    func request<R: DecodableRequest>(_ request: R) async throws -> R.ResponseModel {
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
//                throw Network.generic(error)
                fatalError()
            }
            if err.code.rawValue == NSURLErrorNotConnectedToInternet {
//                throw NetworkError.noConnectedToInternet
            }

            if err.code.rawValue == NSURLErrorTimedOut {
//                throw NetworkError.requestTimeout
            }

//            throw Network.generic(err)
            fatalError()
        }

//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw NetworkError.serverResponseNotValid
//            fatalError()
//        }

//        if httpResponse.statusCode.between(400, and: 499) {
//            if httpResponse.statusCode == 403 {
//            throw NetworkError.forbidden
//            }
//
//            if httpResponse.statusCode == 404 {
//            throw NetworkError.notFound
//            }
//
//            throw NetworkError.clientError(httpResponse.statusCode)
//        }

//        if httpResponse.statusCode.between(500, and: 599) {
//            throw NetworkError.serverError(httpResponse.statusCode)
//        }

        do {
            responseModel = try request.decoder.decode(R.ResponseModel.self, from: data)
        } catch {
//            throw NetworkError.failedToDecode(data)
            fatalError()
        }

        return responseModel
    }
}

@available(iOS 13, macOS 10.15, *)
extension URLSession {
    @available(iOS, deprecated: 15, message: "Should use other instead")
    @available(macOS, deprecated: 12, message: "Should use other instead")
    func data(from request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation({ continuation in
            let task = dataTask(with: request) { data, response, error in
                if let error {
                    return continuation.resume(throwing: error)
                }
                guard let data, let response else { return continuation.resume(throwing: URLError(.badServerResponse)) }
                continuation.resume(returning: (data, response))
            }

            task.resume()
        })
    }
}

// MARK: Example
//let response = try? await dependencies.networkManager.request(SomeRequest())
//print(response.value)

// MARK: - Mocking
struct ServerResponse: Hashable {
    let statusCode: HTTPStatusCode
    let httpVersion: HTTPVersion
    let data: Data?
    let headers: [String: String]
}

enum HTTPStatusCode: Int {
    case code200 = 200
    case code401 = 401
    case code403 = 403
    case code404 = 404
    case code500 = 500
}

enum HTTPVersion: String {
    case onePointOne = "HTTP/1.1"
}

struct NetworkExchange: Hashable {
    let urlRequest: URLRequest
    let response: ServerResponse?
    let error: MockNetworkError?
    var urlResponse: HTTPURLResponse? {
        guard let response = response else {
            return nil
        }

        return HTTPURLResponse(
            url: urlRequest.url!,
            statusCode: response.statusCode.rawValue,
            httpVersion: response.httpVersion.rawValue,
            headerFields: response.headers
        )
    }
}

enum MockNetworkError: Swift.Error, Hashable, Equatable {
    case notConnectedToInternet
    case requestTimeout
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
        case .noURLError:
            return nil
        }
    }
}

final class MockURLProtocol: URLProtocol {
    static var mockRequests: Set<NetworkExchange> = []
    static var delay = 0

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        defer { client?.urlProtocolDidFinishLoading(self) }
        sleep(UInt32(Self.delay))

        let foundedRequest = Self.mockRequests.first { [unowned self] in
            request.url?.path == $0.urlRequest.url?.path && request.httpMethod == $0.urlRequest.httpMethod
        }

        if let error = foundedRequest?.error {
            client?.urlProtocol(self, didFailWithError: error.urlError ?? NSError(domain: "MockURLProtocol", code: 0))
            return
        }

        guard let mockExchange = foundedRequest else {
//            client?.urlProtocol(self, didFailWithError: Network.Mock.Error.routeNotFound)
            return
        }

        if let data = mockExchange.response?.data {
            client?.urlProtocol(self, didLoad: data)
        }

        guard let response = mockExchange.urlResponse else { return }

        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    }

    override func stopLoading() { }
}

extension URLSession {
    static var mock: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
//        Network.Mock.URLProtocol.delay = 2
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        return URLSession(configuration: configuration)
    }
}

extension Mockable {
    static func mockNetworkExchange<R: RawRepresentable>(
        request: URLRequest,
        statusCode: HTTPStatusCode,
        httpVersion: HTTPVersion,
        header: [String: String],
        dataFile: R?
    ) -> NetworkExchange where R.RawValue == String {
        fatalError()
//        guard let fileName = mockDataFile?.rawValue else {
//            return NetworkExchange(urlRequest: request, response: .init(statusCode: statusCode, httpVersion: httpVersion, data: nil, headers: header), error: nil)
//        }
//
//        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
//            return .init(urlRequest: request, response: .init(statusCode: .code404, httpVersion: httpVersion, data: nil, headers: header), error: nil)
//        }
//
//        let content = try! String.init(contentsOfFile: filePath)
//        let data = content.data(using: .utf8)!
//
//        return .init(urlRequest: request, response: .init(statusCode: statusCode, httpVersion: httpVersion, data: data, headers: header), error: nil)
    }
}

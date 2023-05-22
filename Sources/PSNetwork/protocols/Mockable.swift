import Foundation

protocol Mockable {
    static func mockNetworkExchange<R: RawRepresentable>(
        request: URLRequest,
        statusCode: HTTPStatusCode,
        httpVersion: HTTPVersion,
        header: [String: String],
        dataFile: R?
    ) -> NetworkExchange where R.RawValue == String
}

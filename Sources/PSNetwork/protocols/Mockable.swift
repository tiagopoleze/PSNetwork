import Foundation

@available(iOS 13, macOS 10.15, *)
public protocol Mockable {
    static func mockNetworkExchange<R: RawRepresentable>(
        request: URLRequest,
        statusCode: PSNetwork.StatusCode,
        httpVersion: PSNetwork.HTTPVersion,
        header: [String: String],
        dataFile: R?
    ) -> PSNetwork.Mock.NetworkExchange where R.RawValue == String
}

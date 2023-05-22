import Foundation

public protocol DataFile: RawRepresentable {
    associatedtype T: Decodable
    var bundle: Bundle { get }
}

@available(iOS 13, macOS 10.15, *)
public protocol Mockable {
    static func mockNetworkExchange<R: DataFile>(
        request: URLRequest,
        statusCode: PSNetwork.StatusCode,
        httpVersion: PSNetwork.HTTPVersion,
        header: [PSNetwork.Header],
        dataFile: R
    ) -> PSNetwork.Mock.NetworkExchange<R.T> where R.RawValue == String
}

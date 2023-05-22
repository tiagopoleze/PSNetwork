import Foundation

public protocol DataFile: RawRepresentable {
    associatedtype ReturnType: Decodable
    var bundle: Bundle { get }
}

@available(iOS 13, macOS 10.15, *)
public protocol Mockable {
    static func mockNetworkExchange<DFile: DataFile>(
        request: URLRequest,
        statusCode: PSNetwork.StatusCode,
        httpVersion: PSNetwork.HTTPVersion,
        header: [PSNetwork.Header],
        dataFile: DFile,
        error: PSNetwork.Error?
    ) -> PSNetwork.Mock.NetworkExchange<DFile.ReturnType> where DFile.RawValue == String
}

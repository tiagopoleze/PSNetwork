import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
public protocol MockableData: RawRepresentable {
    associatedtype ReturnType: Decodable
    var bundle: Bundle { get }
    var error: PSNetwork.Error? { get }
}

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
public protocol Mockable {
    static func mockNetworkExchange<MockData: MockableData>(
        request: URLRequest,
        statusCode: PSNetwork.StatusCode,
        httpVersion: PSNetwork.HTTPVersion,
        header: [PSNetwork.Header],
        mockData: MockData
    ) -> PSNetwork
        .Mock
        .NetworkExchange<MockData.ReturnType> where MockData.RawValue == String
}

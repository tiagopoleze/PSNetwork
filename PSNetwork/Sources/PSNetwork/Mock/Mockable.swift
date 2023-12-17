import Foundation

/// A protocol that represents mockable data.
public protocol MockableData: RawRepresentable {
    associatedtype ReturnType: Decodable
    var bundle: Bundle { get }
    var error: PSNetwork.Error? { get }
}

/// A protocol that defines a mockable network exchange.
public protocol Mockable {
    
    /// Creates a mock network exchange.
    ///
    /// - Parameters:
    ///   - request: The URL request.
    ///   - statusCode: The status code of the network exchange.
    ///   - httpVersion: The HTTP version of the network exchange.
    ///   - header: The headers of the network exchange.
    ///   - mockData: The mock data for the network exchange.
    /// - Returns: A `Mock.NetworkExchange` object representing the mock network exchange.
    static func mockNetworkExchange<MockData: MockableData>(
        request: URLRequest,
        statusCode: PSNetwork.StatusCode,
        httpVersion: PSNetwork.HTTPVersion,
        header: [PSNetwork.Header],
        mockData: MockData
    ) -> PSNetwork.Mock.NetworkExchange<MockData.ReturnType> where MockData.RawValue == String
}

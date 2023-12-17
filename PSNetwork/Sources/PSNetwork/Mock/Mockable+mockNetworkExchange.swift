import Foundation

public extension Mockable {
    /// A convenience method for creating a mock network exchange with the specified parameters.
    ///
    /// - Parameters:
    ///   - request: The URL request for the network exchange.
    ///   - statusCode: The status code to be returned in the server response.
    ///   - httpVersion: The HTTP version to be used in the server response. Default is `.onePointOne`.
    ///   - header: The headers to be included in the server response. Default is an empty array.
    ///   - mockData: The mock data to be returned in the server response.
    /// - Returns: A `PSNetwork.Mock.NetworkExchange` object with the specified parameters.
    static func mockNetworkExchange<MockData: MockableData>(
        request: URLRequest,
        statusCode: PSNetwork.StatusCode,
        httpVersion: PSNetwork.HTTPVersion = .onePointOne,
        header: [PSNetwork.Header] = [],
        mockData: MockData
    ) -> PSNetwork
        .Mock
        .NetworkExchange<MockData.ReturnType> where MockData.RawValue == String {
            guard let encodable = try? mockData
            .bundle
            .decode(
                MockData.ReturnType.self,
                from: mockData.rawValue
            ) else {
            return PSNetwork.Mock.NetworkExchange(
                urlRequest: request,
                response: PSNetwork.Mock.ServerResponse(
                    statusCode: .notFound
                )
            )
        }

        return PSNetwork.Mock.NetworkExchange(
            urlRequest: request,
            response: PSNetwork.Mock.ServerResponse(
                statusCode: statusCode,
                httpVersion: httpVersion,
                data: encodable,
                headers: header
            ),
            error: mockData.error)
    }
}

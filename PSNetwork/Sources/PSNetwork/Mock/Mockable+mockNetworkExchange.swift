import Foundation

@available(iOS 13, macOS 10.15, tvOS 15, watchOS 7, *)
public extension Mockable {
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
            error: mockData.error
        )
    }
}

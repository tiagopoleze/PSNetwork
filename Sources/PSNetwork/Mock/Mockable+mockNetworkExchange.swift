import Foundation

@available(iOS 13, macOS 10.15, *)
public extension Mockable {
    static func mockNetworkExchange<DFile: DataFile>(
        request: URLRequest,
        statusCode: PSNetwork.StatusCode,
        httpVersion: PSNetwork.HTTPVersion = .onePointOne,
        header: [PSNetwork.Header] = [],
        dataFile: DFile,
        error: PSNetwork.Error? = nil
    ) -> PSNetwork.Mock
        .NetworkExchange<DFile.ReturnType> where DFile.RawValue == String {
        guard let encodable = try? dataFile
            .bundle
            .decode(
                DFile.ReturnType.self,
                from: dataFile.rawValue
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
            error: error
        )
    }
}

import Foundation

@available(iOS 13, macOS 10.15, *)
public extension Mockable {
    static func mockNetworkExchange<R: DataFile>(
        request: URLRequest,
        statusCode: PSNetwork.StatusCode,
        httpVersion: PSNetwork.HTTPVersion,
        header: [PSNetwork.Header],
        dataFile: R
    ) -> PSNetwork.Mock.NetworkExchange<R.T> where R.RawValue == String {
        guard let encodable = try? dataFile.bundle.decode(R.T.self, from: dataFile.rawValue) else {
            return PSNetwork.Mock.NetworkExchange(
                urlRequest: request,
                response: PSNetwork.Mock.ServerResponse(
                    statusCode: .code404
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
            )
        )
    }
}

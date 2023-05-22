import Foundation

@available(iOS 13, macOS 10.15, *)
public extension Mockable {
    static func mockNetworkExchange<R: RawRepresentable>(
        request: URLRequest,
        statusCode: PSNetwork.StatusCode,
        httpVersion: PSNetwork.HTTPVersion,
        header: [String: String],
        bundle: Bundle,
        dataFile: R?
    ) -> PSNetwork.Mock.NetworkExchange where R.RawValue == String {
        guard let fileName = dataFile?.rawValue else {
            return PSNetwork.Mock.NetworkExchange(
                urlRequest: request,
                response: PSNetwork.Mock.ServerResponse(
                    statusCode: .code401
                )
            )
        }

        guard let url = bundle.url(forResource: fileName, withExtension: nil) else {
            return PSNetwork.Mock.NetworkExchange(
                urlRequest: request,
                response: PSNetwork.Mock.ServerResponse(
                    statusCode: .code404
                )
            )
        }
        guard let data = try? Data(contentsOf: url) else {
            return PSNetwork.Mock.NetworkExchange(
                urlRequest: request,
                response: PSNetwork.Mock.ServerResponse(
                    statusCode: .code403
                )
            )
        }

        return PSNetwork.Mock.NetworkExchange(
            urlRequest: request,
            response: PSNetwork.Mock.ServerResponse(
                statusCode: statusCode,
                httpVersion: httpVersion,
                data: data,
                headers: header
            )
        )
    }
}

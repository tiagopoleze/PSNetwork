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
                    statusCode: statusCode
                )
            )
        }

        guard let filePath = try? bundle.decode(String.self, from: fileName) else {
            return PSNetwork.Mock.NetworkExchange(
                urlRequest: request,
                response: PSNetwork.Mock.ServerResponse(
                    statusCode: .code404
                )
            )
        }

        let content = try! String(contentsOfFile: filePath)
        let data = content.data(using: .utf8)!

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

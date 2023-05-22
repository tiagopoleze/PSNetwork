import Foundation

@available(iOS 13, macOS 10.15, *)
public protocol PSRequest: URLRequestConvertible {
    associatedtype ResponseModel: Decodable
    associatedtype Encoder: DataEncoder = JSONEncoder
    associatedtype Decoder: DataDecoder = JSONDecoder

    var authorizationType: PSNetwork.AuthorizationType { get }
    var method: PSNetwork.Method { get }
    var scheme: PSNetwork.Scheme { get }
    var host: String { get }
    var port: Int? { get }
    var path: [String] { get }
    var headers: [PSNetwork.Header] { get }
    var queryItems: [PSNetwork.QueryItem] { get }
    var encoder: Encoder { get }
    var decoder: Decoder { get }
    var timeout: TimeInterval { get }
}

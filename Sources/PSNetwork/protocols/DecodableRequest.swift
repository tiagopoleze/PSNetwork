import Foundation

public protocol DecodableRequest {
    associatedtype ResponseModel: Decodable
    associatedtype HTTPBody: Encodable = EmptyResponseModel
    associatedtype Encoder: DataEncoder = JSONEncoder
    associatedtype Decoder: DataDecoder = JSONDecoder

    var authorizationType: AuthorizationType { get }
    var method: HTTPMethod { get }
    var scheme: NetworkScheme { get }
    var host: String { get }
    var port: Int? { get }
    var path: [String] { get }
    var headers: [HTTPHeader] { get }
    var queryItems: [HTTPQueryItem] { get }
    var httpBody: HTTPBody { get }
    var encoder: Encoder { get }
    var decoder: Decoder { get }
    var timeout: TimeInterval { get }
}

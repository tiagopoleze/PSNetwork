import Foundation

@available(iOS 13, macOS 10.15, *)
public protocol PSRequest: URLRequestConvertible {
    associatedtype BodyParameter: Codable
    associatedtype ResponseModel: Codable
    associatedtype Encoder: DataEncoder = JSONEncoder
    associatedtype Decoder: DataDecoder = JSONDecoder

    var authorizationType: PSNetwork.AuthorizationType { get }
    static var method: PSNetwork.Method { get set }
    static var path: [String] { get }
    var bodyParameter: BodyParameter? { get }
    var scheme: PSNetwork.Scheme { get }
    var host: String { get }
    var port: Int? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var headers: [PSNetwork.Header] { get }
    var queryItems: [PSNetwork.QueryItem] { get }
    var encoder: Encoder { get }
    var decoder: Decoder { get }
    var timeout: TimeInterval { get }
}

@available(iOS 13, macOS 10.15, *)
public extension PSRequest {
    var scheme: PSNetwork.Scheme { .https }
    var port: Int? { nil }
    var timeout: TimeInterval { 60 }
    var path: [String] { [] }
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    var headers: [PSNetwork.Header] { [] }
    var queryItems: [PSNetwork.QueryItem] { [] }
}

public struct EmptyBodyParameter: Codable { }
public struct EmptyResponseModel: Codable { }

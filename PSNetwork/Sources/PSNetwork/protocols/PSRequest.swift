import Foundation

/// A protocol that represents a network request.
public protocol PSRequest: URLRequestConvertible {
    /// The type of the body parameter for the request.
    associatedtype BodyParameter: Codable
    
    /// The type of the response model for the request.
    associatedtype ResponseModel: Codable
    
    /// The type of the data encoder to be used for encoding the request body.
    associatedtype Encoder: DataEncoder = JSONEncoder
    
    /// The type of the data decoder to be used for decoding the response data.
    associatedtype Decoder: DataDecoder = JSONDecoder
    
    /// The authorization type for the request.
    var authorizationType: PSNetwork.AuthorizationType { get }
    
    /// The HTTP method for the request.
    static var method: PSNetwork.Method { get set }
    
    /// The path components for the request URL.
    static var path: [String] { get }
    
    /// The body parameter for the request.
    var bodyParameter: BodyParameter? { get }
    
    /// The scheme for the request URL.
    var scheme: PSNetwork.Scheme { get }
    
    /// The host for the request URL.
    var host: String { get }
    
    /// The port for the request URL.
    var port: Int? { get }
    
    /// The cache policy for the request.
    var cachePolicy: URLRequest.CachePolicy { get }
    
    /// The headers for the request.
    var headers: [PSNetwork.Header] { get }
    
    /// The query items for the request URL.
    var queryItems: [PSNetwork.QueryItem] { get }
    
    /// The data encoder for the request body.
    var encoder: Encoder { get }
    
    /// The data decoder for the response data.
    var decoder: Decoder { get }
    
    /// The timeout interval for the request.
    var timeout: TimeInterval { get }
}

/// Extension for `PSRequest` protocol that provides default values for its properties.
public extension PSRequest {
    /// The scheme used for the request. Default value is `.https`.
    var scheme: PSNetwork.Scheme { .https }
    
    /// The port used for the request. Default value is `nil`.
    var port: Int? { nil }
    
    /// The timeout interval for the request. Default value is `60` seconds.
    var timeout: TimeInterval { 60 }
    
    /// The path components for the request. Default value is an empty array.
    var path: [String] { [] }
    
    /// The cache policy for the request. Default value is `.useProtocolCachePolicy`.
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    
    /// The headers for the request. Default value is an empty array.
    var headers: [PSNetwork.Header] { [] }
    
    /// The query items for the request. Default value is an empty array.
    var queryItems: [PSNetwork.QueryItem] { [] }
}

/// Represents a parameter with an empty body.
public struct EmptyBodyParameter: Codable { }

/// Represents a response model with no data.
public struct EmptyResponseModel: Codable { }

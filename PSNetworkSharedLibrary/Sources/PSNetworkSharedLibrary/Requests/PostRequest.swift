import PSNetwork

public struct PostRequest: PSRequest {
    public typealias ResponseModel = PostOutput
    public var host: String = "localhost"
    public var port: Int? = 8080
    public static var path: [String] = ["api"]
    public var authorizationType: PSNetwork.AuthorizationType = .none
    public static var method: PSNetwork.Method = .post
    public var scheme: PSNetwork.Scheme = .http
    public var bodyParameter: PostInput?

    public init() { }
}

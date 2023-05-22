import Foundation

@available(iOS 13, macOS 10.15, *)
public extension PSNetwork {
    enum StatusCode: Int {
        case code200 = 200
        case code401 = 401
        case code403 = 403
        case code404 = 404
        case code500 = 500
    }
}

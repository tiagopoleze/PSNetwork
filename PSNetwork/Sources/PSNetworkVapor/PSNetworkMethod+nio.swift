import PSNetwork
import Vapor

extension PSNetwork.Method {
    var nio: NIOHTTP1.HTTPMethod {
        switch self {
        case .get: 
            return .GET
        case .post: 
            return .POST
        case .put: 
            return .PUT
        case .patch: 
            return .PATCH
        case .delete: 
            return .DELETE
        }
    }
}

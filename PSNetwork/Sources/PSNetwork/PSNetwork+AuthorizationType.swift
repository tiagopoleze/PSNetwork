import Foundation

public extension PSNetwork {
    /**
     Represents the authorization type for a PSNetwork request.
     The `addAuthorization(to:)` method can be used to add the authorization to a URLRequest.

     Example usage:

     ```
     var request = URLRequest(url: url)
     let authorization = AuthorizationType.bearer("YOUR_TOKEN")
     authorization.addAuthorization(to: &request)
     ```
    */
    enum AuthorizationType {
        /// - none: No authorization required.
        case none
        /// - header: Authorization using a custom header.
        case header(PSNetwork.Header)
        /// - bearer: Authorization using a bearer token.
        case bearer(String)

        /**
         Adds the authorization to the specified URLRequest.

         - Parameter request: The URLRequest to add the authorization to.
        */
        func addAuthorization(to request: inout URLRequest) {
            switch self {
            case .none:
                break
            case let .header(header):
                request.addValue(header.value, forHTTPHeaderField: header.key)
            case let .bearer(token):
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
    }
}

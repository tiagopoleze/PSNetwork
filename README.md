# PSNetwork

[![Swift](https://github.com/tiagopoleze/PSNetwork/actions/workflows/swift.yml/badge.svg)](https://github.com/tiagopoleze/PSNetwork/actions/workflows/swift.yml)

This is a package to help you to create requests.

## How to use it

Conforme a Model to `Codable` and `Hashable`
```Swift
struct RegresModel: Codable, Hashable {
    let data: RegresModel.Data
    let support: RegresModel.Support

    struct Data: Codable, Hashable {
        let id: Int
        let email: String
        let firstName: String
        let lastName: String
        let avatar: String
    }
    struct Support: Codable, Hashable {
        let url: String
        let text: String
    }
}
```

Then, create a struct to deal with the request:
```Swift
struct RegresRequest: PSRequest {
    typealias ResponseModel = RegresModel
    var bodyParameter: EmptyBodyParameter? = nil
    var authorizationType: PSNetwork.AuthorizationType = .none
    var host: String = "reqres.in"
    static var path: [String] = ["api", "users", "2"]
    static var method: PSNetwork.Method = .get
}
```

The call will be:
```Swift
let manager = PSNetwork.NetworkManager()
let response = try await manager.request(RegresRequest())
```

This response will be a `RegresModel` type.

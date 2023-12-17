import XCTest
import PSNetwork
import Vapor
@testable import PSNetworkVapor

final class PSNetworkVaporTests: XCTestCase {
    let app = Vapor.Application()
    func testExample() throws {
        XCTAssertEqual(app.routes.all.count, 0)
        GetRequest.register(with: app)
        XCTAssertEqual(app.routes.all.count, 1)
    }
}

extension EmptyBodyParameter: Content { }
struct GetOutput: Content {
    let name: String
}

extension GetOutput: AsyncResponseEncodable { }

struct GetRequest: PSRequest {
    typealias ResponseModel = GetOutput

    static var method: PSNetwork.Method = .get
    static var path: [String] = []

    var bodyParameter: EmptyBodyParameter?
    var authorizationType: PSNetwork.AuthorizationType = .none
    var host: String = ""
}

extension GetRequest: PSEndpoint {
    static func register(with routes: RoutesBuilder) {
        routes.endpoint(self) { _, _ in
            GetOutput(name: "Tiago")
        }
    }
}

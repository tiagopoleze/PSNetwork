import XCTest
@testable import PSNetwork

@available(iOS 13, *)
final class PSNetworkTests: XCTestCase {
    var manager: PSNetwork.Manager?

    override func setUp() {
        manager = .init()
    }

    override func tearDown() {
        manager = nil
    }

    func testExample() async throws {
        let networkExchange = PSNetwork.Mock.NetworkExchange(
            urlRequest: URLRequest(url: URL(string: "https://example.com")!),
            response: PSNetwork.Mock.ServerResponse(
                statusCode: .ok,
                httpVersion: .onePointOne,
                data: "{\"text\": \"Some data\"}".data(using: .utf8),
                headers: []
            ),
            error: nil)

        PSNetwork.Mock.URLProtocol.mockRequests.insert(networkExchange)
        let expectedResponse = DemoResponse("Some data")

        manager = PSNetwork.Mock.Manager
        let actualResponse = try await manager?.request(DemoGetRequest())
        XCTAssertEqual(actualResponse, expectedResponse)
    }

    func testReal() async throws {
        let response = try await manager?.request(RegresRequest())
        let expectedResponse = RegresModel(
            data: RegresModel.Data(
                id: 2,
                email: "janet.weaver@reqres.in",
                firstName: "Janet",
                lastName: "Weaver",
                avatar: "https://reqres.in/img/faces/2-image.jpg"),
            support: RegresModel.Support(
                url: "https://reqres.in/#support-heading",
                text: "To keep ReqRes free, contributions towards server costs are appreciated!"
            )
        )

        XCTAssertEqual(response, expectedResponse)
    }
}

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

@available(iOS 13, *)
struct RegresRequest: PSRequest {
    typealias ResponseModel = RegresModel
    var bodyParameter: EmptyBodyParameter?
    var authorizationType: PSNetwork.AuthorizationType = .none
    var host: String = "reqres.in"
    static var path: [String] = ["api", "users", "2"]
    static var method: PSNetwork.Method = .get
}

struct DemoResponse: Codable, Hashable {
    let text: String

    init(_ text: String) {
        self.text = text
    }
}

@available(iOS 13, *)
struct DemoGetRequest: PSRequest {
    typealias ResponseModel = DemoResponse
    var bodyParameter: EmptyBodyParameter?
    static var path: [String] = []
    static var method: PSNetwork.Method = .get
    var authorizationType: PSNetwork.AuthorizationType = .none
    var host: String = "example.com"
    var timeout: TimeInterval = 0
}

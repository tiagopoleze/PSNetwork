import XCTest
@testable import PSNetwork

final class PSNetworkTests: XCTestCase {
    func testExample() async throws {
        let networkExchange = PSNetwork.Mock.NetworkExchange(
            urlRequest: URLRequest(url: URL(string: "https://example.com")!),
            response: PSNetwork.Mock.ServerResponse(
                statusCode: .code200,
                httpVersion: .onePointOne,
                data: "{\"text\": \"Some data\"}".data(using: .utf8),
                headers: [:]
            ),
            error: nil)

        PSNetwork.Mock.URLProtocol.mockRequests.insert(networkExchange)
        let expectedResponse = DemoResponse("Some data")
        
        let networkManager = PSNetwork.Mock.Manager
        let actualResponse = try await networkManager.request(DemoGetRequest())
        XCTAssertEqual(actualResponse, expectedResponse)
    }

    func testReal() async throws {
        let manager = PSNetwork.NetworkManager(using: .shared)
        let response = try await manager.request(RegresRequest())
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

struct RegresRequest: PSRequest {
    typealias ResponseModel = RegresModel
    var authorizationType: PSNetwork.AuthorizationType = .none
    var method: PSNetwork.Method = .get
    var scheme: PSNetwork.Scheme = .https
    var host: String = "reqres.in"
    var port: Int? = nil
    var path: [String] = ["api", "users", "2"]
    var headers: [PSNetwork.Header] = []
    var queryItems: [PSNetwork.QueryItem] = []
    var timeout: TimeInterval = 60
}

struct DemoResponse: Codable, Hashable {
    let text: String

    init(_ text: String) {
        self.text = text
    }
}

struct DemoGetRequest: PSRequest {
    typealias ResponseModel = DemoResponse
    var authorizationType: PSNetwork.AuthorizationType = .none
    var method: PSNetwork.Method = .get
    var scheme: PSNetwork.Scheme = .https
    var host: String = "example.com"
    var port: Int? = nil
    var path: [String] = []
    var headers: [PSNetwork.Header] = []
    var queryItems: [PSNetwork.QueryItem] = []
    var timeout: TimeInterval = 20
}

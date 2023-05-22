import XCTest
@testable import PSNetwork

final class PSNetworkTests: XCTestCase {
    func testExample() async throws {
        let networkExchange = NetworkExchange(urlRequest: URLRequest(url: URL(string: "")!), response: ServerResponse(statusCode: .code200, httpVersion: .onePointOne, data: "{\"text\": \"Some data\"}".data(using: .utf8), headers: [:]), error: nil)

        MockURLProtocol.mockRequests.insert(networkExchange)
//        let expectedResponse = DemoResponse("Some data")
//        let request = DemoGetRequest()
        let networkManager = NetworkManager(using: URLSession.mock)
//        let actualResponse = try await networkManager.request(request)
//        XCTAssertEqual(actualResponse, expectedResponse)
    }
}

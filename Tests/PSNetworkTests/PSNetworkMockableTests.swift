import XCTest
import Foundation
@testable import PSNetwork

final class PSNetworkMockableTests: XCTestCase {
    func testExample() throws {
        let bundle = Bundle()
        let networkExchange = MyMockable.mockNetworkExchange(
            request: .init(url: URL(string: "https://example.com")!),
            statusCode: .code404,
            httpVersion: .onePointOne,
            header: [:],
            bundle: bundle,
            dataFile: MyDataFile(rawValue: "test")
        )
        XCTAssertEqual(networkExchange.response?.statusCode, .code404)
    }

    func testOther() throws {
        let networkExchange = MyMockable.mockNetworkExchange(
            request: .init(url: URL(string: "https://example.com")!),
            statusCode: .code200,
            httpVersion: .onePointOne,
            header: [:],
            bundle: .module,
            dataFile: MyDataFile(rawValue: "other.json")
        )
        
        XCTAssertEqual(networkExchange.response?.statusCode, .code200)
    }
}

struct MyMockable: Mockable {}
struct Other: Codable {
    let name: String
}

struct MyDataFile: RawRepresentable {
    var rawValue: String
    init?(rawValue: String) {
        self.rawValue = rawValue
    }
}

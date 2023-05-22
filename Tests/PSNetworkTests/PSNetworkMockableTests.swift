import XCTest
import Foundation
@testable import PSNetwork

@available(iOS 13, *)
final class PSNetworkMockableTests: XCTestCase {
    var networkExchange: PSNetwork.Mock.NetworkExchange<MyDataFile.ReturnType>?

    override func tearDown() {
        networkExchange = nil
    }

    func testExample() throws {
        networkExchange = MyMockable.mockNetworkExchange(
            request: .init(url: URL(string: "https://example.com")!),
            statusCode: .notFound,
            httpVersion: .onePointOne,
            header: [],
            dataFile: MyDataFile("test")
        )
        XCTAssertEqual(networkExchange?.response?.statusCode, .notFound)
    }

    func testOther() throws {
        networkExchange = MyMockable.mockNetworkExchange(
            request: .init(url: URL(string: "https://example.com")!),
            statusCode: .ok,
            httpVersion: .onePointOne,
            header: [],
            dataFile: MyDataFile("other.json")
        )

        XCTAssertEqual(networkExchange?.response?.statusCode, .ok)
        XCTAssertEqual(networkExchange?.response?.data?.name, "Tiago Ferreira")
    }
}

struct MyMockable: Mockable {}
struct Other: Codable, Hashable {
    let name: String
}

struct MyDataFile: DataFile {
    typealias ReturnType = Other

    let rawValue: String
    let bundle: Bundle = .module

    init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    init?(rawValue: String) {
        self.rawValue = rawValue
    }
}

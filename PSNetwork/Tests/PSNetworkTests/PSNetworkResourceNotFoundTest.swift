//
//  PSNetworkResourceNotFoundTest.swift
//  
//
//  Created by Tiago Ferreira on 23/05/2023.
//

import XCTest
@testable import PSNetwork

final class PSNetworkResourceNotFoundTest: XCTestCase {

    func test_resource_not_found_call() async {
        let manager = PSNetwork.NetworkManager()
        do {
            _ = try await manager.request(RegresResourceNotFoundRequest())
        } catch let error as PSNetwork.Error {
            XCTAssertEqual(PSNetwork.Error.notFound, error)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

struct RegresResourceNotFoundRequest: PSRequest {
    typealias ResponseModel = EmptyResponseModel
    var bodyParameter: EmptyBodyParameter? = nil
    var authorizationType: PSNetwork.AuthorizationType = .none
    var host: String = "reqres.in"
    var path: [String] = ["api", "unknown", "23"]
    var method: PSNetwork.Method = .get
}

//
//  PSNetworkPostTest.swift
//  
//
//  Created by Tiago Ferreira on 23/05/2023.
//

import XCTest
@testable import PSNetwork

final class PSNetworkPostTest: XCTestCase {

    func test_create_PSRequest_call() async throws {
        let name = "morpheus"
        let job = "leader"
        let manager = PSNetwork.Manager()
        let response = try await manager.request(
            RegresCreateRequest(
                body: RegresCreateInputDTO(
                    name: name,
                    job: job
                )
            )
        )
        XCTAssertEqual(response.name, name)
        XCTAssertEqual(response.job, job)
    }
}

struct RegresCreateInputDTO: Codable {
    let name: String
    let job: String
}

struct RegresCreateOutputDTO: Codable, Hashable {
    let name: String
    let job: String
    let id: String
    let createdAt: String
}

struct RegresCreateRequest: PSRequest {
    typealias ResponseModel = RegresCreateOutputDTO
    var authorizationType: PSNetwork.AuthorizationType = .none
    var host: String = "reqres.in"
    static var path: [String] = ["api", "users"]
    static var method: PSNetwork.Method = .post
    var bodyParameter: RegresCreateInputDTO?

    init(body: RegresCreateInputDTO) {
        bodyParameter = body
    }
}

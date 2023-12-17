//
//  requests.swift
//  
//
//  Created by Tiago Ferreira on 04/06/2023.
//

import Vapor
import PSNetworkVapor
import PSNetworkSharedLibrary

extension GetRequest: PSEndpoint {
    public static func register(with routes: Vapor.RoutesBuilder) {
        routes.endpoint(self) { _, _ in
            .init(id: UUID().uuidString, name: "Tiago")
        }
    }
}

extension PostRequest: PSEndpoint {
    public static func register(with routes: RoutesBuilder) {
        routes.endpoint(self) { _, body in
            .init(id: UUID().uuidString, name: body?.name ?? "No name")
        }
    }
}

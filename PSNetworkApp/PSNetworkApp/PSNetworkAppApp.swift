//
//  PSNetworkAppApp.swift
//  PSNetworkApp
//
//  Created by Tiago Ferreira on 17/12/2023.
//

import SwiftUI
import PSNetwork

@main
struct PSNetworkAppApp: App {
    @StateObject private var networkManager: PSNetwork.Manager
    
    init() {
        _networkManager = StateObject(wrappedValue: PSNetwork.Manager())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(networkManager)
        }
    }
}

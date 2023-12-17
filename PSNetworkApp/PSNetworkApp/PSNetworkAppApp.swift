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
    @StateObject private var networkManager: PSNetwork.NetworkManager
    
    init() {
        _networkManager = StateObject(wrappedValue: PSNetwork.NetworkManager())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(networkManager)
        }
    }
}

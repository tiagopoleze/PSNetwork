//
//  ContentView.swift
//  PSNetworkApp
//
//  Created by Tiago Ferreira on 17/12/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    GetView()
                } label: {
                    Text("Using server")
                }
                NavigationLink {
                    GetView(isMocked: true)
                } label: {
                    Text("Mocked")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

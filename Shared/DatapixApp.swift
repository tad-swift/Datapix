//
//  DatapixApp.swift
//  Shared
//
//  Created by Tadreik Campbell on 1/30/21.
//

import SwiftUI

@main
struct DatapixApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            NavigationView {
                Sidebar()
                ContentView()
            }
            #else
            NavigationView {
                HomeScreen()
            }
            #endif
        }
    }
}

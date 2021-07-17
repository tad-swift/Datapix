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
                    .frame(minWidth: 200, idealWidth: 200, maxWidth: 250, maxHeight: .infinity)
                Editbar()
                    .frame(minWidth: 250, idealWidth: 250, maxWidth: 300, maxHeight: .infinity)
                ContentView()
                    .frame(minWidth: 500, idealWidth: 500, maxWidth: .infinity, maxHeight: .infinity)
            }
            #else
            NavigationView {
                HomeScreen()
                    .navigationBarTitle("Datapix")
            }
            #endif
        }
        .commands {
            CommandGroup(after: .newItem) {
                Divider()
                Button(action: {
                    
                }) {
                    Text("Import")
                }
                .keyboardShortcut(KeyEquivalent("i"), modifiers: .command)
                Button(action: {
                    
                }) {
                    Text("Export")
                }
                .keyboardShortcut(KeyEquivalent("e"), modifiers: .command)
            }
        }
    }
}

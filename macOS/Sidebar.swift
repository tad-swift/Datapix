//
//  Sidebar.swift
//  Datapix (macOS)
//
//  Created by Tadreik Campbell on 1/30/21.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            Section(header: Text("Section 1")) {
                NavigationLink(
                    destination: SettingsScreen(),
                    label: {
                        Label("Choose Photo", systemImage: "photo.fill" )
                    })
            }
            Section(header: Text("Section 2")) {
                NavigationLink(
                    destination: BlurStrengthScreen(),
                    label: {
                        Label("Blur Strength", systemImage: "slider.horizontal.below.square.fill.and.square" )
                    })
                NavigationLink(
                    destination: BlurStyleScreen(),
                    label: {
                        Label("Blur Style", systemImage: "list.dash" )
                    })
                NavigationLink(
                    destination: TextAdjustmentsScreen(),
                    label: {
                        Label("Text Adjustments", systemImage: "text.cursor" )
                    })
                NavigationLink(
                    destination: AddMoreInfoScreen(),
                    label: {
                        Label("Add More Info", systemImage: "info.circle" )
                    })
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 150, idealWidth: 180, maxWidth: 200, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                }) {
                    Image(systemName: "sidebar.left")
                }
                .keyboardShortcut("S", modifiers: .command)
            }
        }
    }
}

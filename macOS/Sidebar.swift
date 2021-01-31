//
//  Sidebar.swift
//  Datapix (macOS)
//
//  Created by Tadreik Campbell on 1/30/21.
//

import SwiftUI

struct Sidebar: View {
    @State var selectedTool = 0
    let tools = ["Brush","Text"]
    var body: some View {
        List {
            Section(header: Text("Tools")) {
                NavigationLink(
                    destination: BrushScreen(),
                    label: {
                        Label("Brush", systemImage: "paintbrush.fill" )
                    })
                NavigationLink(
                    destination: TextScreen(),
                    label: {
                        Label("Add Text", systemImage: "text.cursor" )
                    })
            }
            Section(header: Text("Adjustments")) {
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
                        Label("Text Adjustments", systemImage: "textformat.alt" )
                    })
                NavigationLink(
                    destination: AddMoreInfoScreen(),
                    label: {
                        Label("Add More Info", systemImage: "info.circle" )
                    })
            }
        }
        .listStyle(SidebarListStyle())
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                }) {
                    Image(systemName: "sidebar.left")
                }
            }
        }
    }
}

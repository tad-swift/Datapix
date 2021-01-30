//
//  SettingsScreen.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/23/20.
//

import SwiftUI

struct SettingsScreen: View {
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Image Adjustments")) {
                    NavigationLink(destination: BlurStrengthScreen()) {
                        Text("Blur strength")
                    }
                    NavigationLink(destination: BlurStyleScreen()) {
                        Text("Blur style")
                    }
                    NavigationLink(destination: TextAdjustmentsScreen()) {
                        Text("Text adjustments")
                    }
                    NavigationLink(destination: AddMoreInfoScreen()) {
                        Text("Add more info")
                    }
                }
            }
            .listStyle(InsetListStyle())
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
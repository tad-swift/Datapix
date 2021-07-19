//
//  BlurStrengthScreen.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/23/20.
//

import SwiftUI

struct BlurStrengthScreen: View {
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        VStack {
            List {
                Section() {
                    HStack {
                        Text("0")
                            .padding(.trailing)
                        Slider(value: $userSettings.blurStrength, in: 0...20, step: 2)
                        Text("20")
                            .padding(.leading)
                    }
                    .padding(.vertical, 4)
                }
                .font(.system(size: 17, weight: .medium, design: .rounded))
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Select a blur strength", displayMode: .inline)
        }
    }
}

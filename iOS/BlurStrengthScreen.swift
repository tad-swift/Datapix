//
//  BlurStrengthScreen.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/23/20.
//

import SwiftUI

struct BlurStrengthScreen: View {
    @State private var currentValue: Float = UserSettings().blurStrength
    var body: some View {
        VStack {
            List {
                Section() {
                    HStack {
                        Text("0")
                            .padding(.trailing)
                        Slider(value: $currentValue, in: 0...20, step: 2, onEditingChanged: { _ in
                            UserSettings().blurStrength = currentValue
                        })
                        Text("20")
                            .padding(.leading)
                    }
                    .padding(.vertical)
                }
                .font(.system(size: 17, weight: .medium, design: .rounded))
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Select a blur strength", displayMode: .inline)
        }
    }
}

struct BlurStrengthScreen_Preview: PreviewProvider {
    static var previews: some View {
        BlurStrengthScreen()
    }
    
}

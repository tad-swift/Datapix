//
//  AddMoreInfoScreen.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/23/20.
//

import SwiftUI

struct AddMoreInfoScreen: View {
    @State private var sampleText: String = ""
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        List {
            Section() {
                HStack {
                    Image(systemName: "c.circle")
                        .resizable()
                        .frame(width: 18, height: 18)
                    TextField("Copyright", text: $userSettings.copyrightText)
                }
                HStack {
                    Image("instagram")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                    TextField("Instagram", text: $userSettings.instagramText)
                }
                HStack {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 18, height: 18)
                    TextField("Any additional info", text: $userSettings.additionalText)
                }
            }
            .font(.system(size: 17, weight: .regular, design: .default))
            .padding(.vertical, 3)
        }
        .listStyle(InsetListStyle())
        .navigationBarTitle("Edit text", displayMode: .inline)
    }
}

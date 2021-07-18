//
//  TextAdjustmentsScreen.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/23/20.
//

import SwiftUI

struct TextAdjustmentsScreen: View {
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        List {
            Section() {
                Toggle("Camera model", isOn: $userSettings.cameraModelChecked)
                
                Toggle("Camera software", isOn: $userSettings.cameraSoftwareChecked)
                
                Toggle("Aperture", isOn: $userSettings.apertureChecked)
                
                Toggle("Focal legth", isOn: $userSettings.focalChecked)
                
                Toggle("ISO", isOn: $userSettings.isoChecked)
                
                Toggle("Lens model", isOn: $userSettings.lensModelChecked)
                
                Toggle("Shutter speed", isOn: $userSettings.shutterSpeedChecked)
            }
            .font(.system(size: 17, weight: .regular, design: .default))
            .toggleStyle(DefaultToggleStyle())
            
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Visible data", displayMode: .inline)
    }
}

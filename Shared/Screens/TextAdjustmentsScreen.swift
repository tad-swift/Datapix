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
            Section(header: Text("Visible data")) {
                Toggle("Camera model", isOn: $userSettings.cameraModelChecked)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .toggleStyle(SwitchToggleStyle(tint: Color.accentColor))
                
                Toggle("Camera software", isOn: $userSettings.cameraSoftwareChecked)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .toggleStyle(SwitchToggleStyle(tint: Color.accentColor))
                
                Toggle("Aperture", isOn: $userSettings.apertureChecked)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .toggleStyle(SwitchToggleStyle(tint: Color.accentColor))
                
                Toggle("Focal legth", isOn: $userSettings.focalChecked)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .toggleStyle(SwitchToggleStyle(tint: Color.accentColor))
                
                Toggle("ISO", isOn: $userSettings.isoChecked)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .toggleStyle(SwitchToggleStyle(tint: Color.accentColor))
                
                Toggle("Lens model", isOn: $userSettings.lensModelChecked)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .toggleStyle(SwitchToggleStyle(tint: Color.accentColor))
                
                Toggle("Shutter speed", isOn: $userSettings.shutterSpeedChecked)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .toggleStyle(SwitchToggleStyle(tint: Color.accentColor))
            }
            
        }
        .listStyle(PlainListStyle())
    }
}

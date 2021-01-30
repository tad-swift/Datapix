//
//  BlurStyleScreen.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/23/20.
//

import SwiftUI

struct BlurStyleScreen: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    let blurTypes = ["Gaussian Blur", "Box Blur", "Disc Blur",
                      "Motion Blur", "Zoom Blur", "Bokeh Blur"]
    var selectedBlur: String {
        switch userSettings.blurStyle {
            case "CIGaussianBlur":
                return "Gaussian Blur"
            case "CIBoxBlur":
                return "Box Blur"
            case "CIDiscBlur":
                return "Disc Blur"
            case "CIMotionBlur":
                return "Motion Blur"
            case "CIZoomBlur":
                return "Zoom Blur"
            case "CIBokehBlur":
                return "Bokeh Blur"
            default:
                return "Gaussian Blur"
        }
    }
    
    var body: some View {
        VStack {
            #if os(macOS)
            Picker(selection: $userSettings.blurStyle, label: Text("")) {
                Text("Gaussian Blur").tag("Gaussian Blur")
                Text("Box Blur").tag("Box Blur")
                Text("Disc Blur").tag("Disc Blur")
                Text("Motion Blur").tag("Motion Blur")
                Text("Zoom Blur").tag("Zoom Blur")
                Text("Bokeh Blur").tag("Bokeh Blur")
            }
            .pickerStyle(RadioGroupPickerStyle())
            Spacer()
            #else
            RadioButtonGroup(items: blurTypes, selectedId: selectedBlur) { selected in
                switch selected {
                    case "Gaussian Blur":
                        userSettings.blurStyle = "CIGaussianBlur"
                    case "Box Blur":
                        userSettings.blurStyle = "CIBoxBlur"
                    case "Disc Blur":
                        userSettings.blurStyle = "CIDiscBlur"
                    case "Motion Blur":
                        userSettings.blurStyle = "CIMotionBlur"
                    case "Zoom Blur":
                        userSettings.blurStyle = "CIZoomBlur"
                    case "Bokeh Blur":
                        userSettings.blurStyle = "CIBokehBlur"
                    default:
                        userSettings.blurStyle = "CIGaussianBlur"
                }
            }
            Spacer()
            #endif
        }
        .padding()
    }
    
}

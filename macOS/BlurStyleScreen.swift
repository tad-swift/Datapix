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
            HStack {
                Picker(selection: $userSettings.blurStyle, label: Text("")) {
                    Text("Gaussian Blur").tag("CIGaussianBlur")
                    Text("Box Blur").tag("CIBoxBlur")
                    Text("Disc Blur").tag("CIDiscBlur")
                    Text("Motion Blur").tag("CIMotionBlur")
                    Text("Zoom Blur").tag("CIZoomBlur")
                    Text("Bokeh Blur").tag("CIBokehBlur")
                }
                .pickerStyle(RadioGroupPickerStyle())
                Spacer()
            }
            Spacer()
        }
        .font(.system(size: 17, weight: .regular, design: .default))
        .padding()
    }
    
}


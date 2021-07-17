//
//  CardView.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/23/20.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Let's get started!")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .opacity(0.9)
            Spacer()
            Text("Choose a photo and all the exif data will be overlayed onto it. It will be saved as a new photo.")
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .opacity(0.9)
            Spacer()
            NavigationLink(destination: PreviewScreen()) {
                Text("Continue")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.accentColor)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.accentColor, lineWidth: 2))
            }
            Spacer()
        }
        .padding(.horizontal)
        .background(LinearGradient(gradient: Gradient(colors: [Color("AccentColor"), Color("!AccentColor")]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .frame(width: UIScreen.main.bounds.width - 4, height: 320, alignment: .center)
    }
    
}

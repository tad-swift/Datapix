//
//  BlurStrengthScreen.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/23/20.
//

import SwiftUI

struct BlurStrengthScreen: View {
    @State private var lowBlur = UserSettings().lowBlur
    var body: some View {
        VStack {
            List {
                Section() {
                    HStack {
                        VStack {
                            Image("instagram")
                                .resizable()
                                .frame(height: 100)
                                .blur(radius: 1.8)
                                .cornerRadius(16)
                            Text("Subtle")
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                .padding(.top, 8)
                            Image(systemName: lowBlur ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.accentColor)
                                .padding(.vertical, 8)
                        }
                        .onTapGesture(count: 1, perform: {
                            lowBlur = true
                            UserSettings().lowBlur = true
                        })
                        VStack {
                            Image("instagram")
                                .resizable()
                                .frame(height: 100)
                                .blur(radius: 4)
                                .cornerRadius(16)
                            Text("Strong")
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                .padding(.top, 8)
                            Image(systemName: !lowBlur ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.accentColor)
                                .padding(.vertical, 8)
                        }
                        .onTapGesture(count: 1, perform: {
                            lowBlur = false
                            UserSettings().lowBlur = false
                        })
                    }
                    .padding(.vertical, 8)
                }
                .font(.system(size: 17, weight: .regular, design: .default))
            }
            .listStyle(InsetListStyle())
        }
    }
    
}


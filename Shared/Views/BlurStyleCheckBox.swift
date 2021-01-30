//
//  BlurStyleCheckBox.swift
//  Datapix
//
//  Created by Tadreik Campbell on 1/23/21.
//

import SwiftUI

struct RadioButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let id: String
    let callback: (String)->()
    let selectedID : String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    
    init(
        _ id: String,
        callback: @escaping (String)->(),
        selectedID: String,
        size: CGFloat = 20,
        color: Color = .accentColor,
        textSize: CGFloat = 20
    ) {
        self.id = id
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 16) {
                Image(systemName: self.selectedID == self.id ? "checkmark.square" : "square")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .foregroundColor(self.selectedID == self.id ? self.color : Color.primary)
                Text(id)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.selectedID == self.id ? self.color : Color.primary)
        }
        .padding(.vertical, 5)
        .foregroundColor(self.selectedID == self.id ? self.color : Color.primary)
    }
}

struct RadioButtonGroup: View {
    
    let items : [String]
    
    @State var selectedId: String = ""
    
    let callback: (String) -> ()
    
    var body: some View {
        #if os(macOS)
        
        #else
        VStack {
            ForEach(0..<items.count) { index in
                RadioButton(self.items[index], callback: self.radioGroupCallback, selectedID: self.selectedId)
            }
        }
        #endif
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

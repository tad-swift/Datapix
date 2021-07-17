//
//  BottomSheetView.swift
//  Datapix
//
//  Created by Tadreik Campbell on 1/24/21.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    
    @Binding var isOpen: Bool
    @GestureState private var translation: CGFloat = 0
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color(.white))
            .frame(width: Constants.indicatorWidth, height: Constants.indicatorHeight)
    }
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.maxHeight = maxHeight
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.content = content()
        self._isOpen = isOpen
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.systemGray5))
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: self.offset)
            .animation(.interactiveSpring(), value: isOpen)
            .animation(.interactiveSpring(), value: translation)
            .gesture(DragGesture().updating(self.$translation) { value, state, _ in
                state = value.translation.height
            }.onEnded { value in
                let snapDistance = self.maxHeight * Constants.snapRatio
                guard abs(value.translation.height) > snapDistance else { return }
                self.isOpen = value.translation.height < 0
            }
            )
        }
    }
}

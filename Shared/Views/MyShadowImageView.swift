//
//  MyShadowImageView.swift
//  Datapix
//
//  Created by Tadreik Campbell on 1/24/21.
//

import SwiftUI

struct MyShadowImageView: UIViewRepresentable {
    
    @Binding var image: UIImage
    
    func makeUIView(context: Context) -> ShadowImageView {
        let view = ShadowImageView()
        view.imageCornerRaidus = 10
        view.blurRadius = 2.5
        view.contentMode = .scaleAspectFit
        return view
    }
    func updateUIView(_ uiView: ShadowImageView, context: Context) {
        uiView.image = image
    }
}

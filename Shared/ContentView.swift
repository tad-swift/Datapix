//
//  ContentView.swift
//  Shared
//
//  Created by Tadreik Campbell on 1/30/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        #if os(macOS)
        PreviewScreenMac()
        #else
        PreviewScreen()
        #endif
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

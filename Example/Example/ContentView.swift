//
//  ContentView.swift
//  Example
//
//  Created by Kristof Kalai on 2022. 12. 22..
//

import InteractiveView
import SwiftUI

struct ContentView: View {
    var body: some View {
        InteractiveView {
            TabView {
                ForEach(["First", "Second"], id: \.self, content: Text.init)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        } changed: {
            print("state: \($0), isInteracting: \($0.isInteracting)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

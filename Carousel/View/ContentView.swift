//
//  ContentView.swift
//  Carousel
//
//  Created by Fatih Emre Sarman on 11.03.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ThemeColor(red: 50, green: 30, blue: 87)
                .zIndex(1)
            ThemeColor(red: 226, green: 77, blue: 108)
                .zIndex(0.5)
                .offset(y: -35)
            ThemeColor(red: 90, green: 105, blue: 56)
                .zIndex(0)
                .offset(y: -35*2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

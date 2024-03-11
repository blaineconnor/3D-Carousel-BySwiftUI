//
//  ThemeFont.swift
//  Carousel
//
//  Created by Fatih Emre Sarman on 11.03.2024.
//

import SwiftUI

struct ThemeFont: View {
    let name: String
    let color: Color
    let scale: CGFloat
    
    var body: some View {
        let width: CGFloat = 57*scale
        let height: CGFloat = 90*scale
        
        VStack(alignment: .trailing) {
            Spacer()
            HStack {
                VStack(alignment: .trailing) {
                    HStack(alignment: .top, spacing: 0) {
                        Text("Blaine")
                            .font(Font.custom("HelveticaNeue-Bold", size: 7.5*scale))
                        Text("®")
                            .font(Font.custom("HelveticaNeue-Bold", size: 3*scale))
                    }
                    Text(name)
                        .font(Font.custom("HelveticaNeue-Bold", size: 6.5*scale))
                }
                Spacer()
            }
            .padding(.horizontal, 5)
            .frame(width: width - 3 * scale, height: height / 3.5)
            .background(RoundedRectangle(cornerRadius: 5)
                            .fill(Color.white))
            
        }
        .padding(3)
        .frame(width: width, height: height)
        .background(RoundedRectangle(cornerRadius: 5).fill(color))
    }
    
    init(name: String, color: Color, scale: CGFloat) {
        self.name = name
        self.color = color
        self.scale = scale
    }
}

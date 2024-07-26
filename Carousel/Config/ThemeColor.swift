//
//  Color.swift
//  Carousel
//
//  Created by Fatih Emre Sarman on 11.03.2024.
//

import SwiftUI

struct ThemeColor: View {
    var chipShapes: [ThemeFont]
    let zIndexPreset: [Double]
    
    init(red: Int, green: Int, blue: Int) {
        chipShapes = [ThemeFont]()
        
        for i in (0..<32) {
            self.chipShapes.append(
                ThemeFont(name: String(format: "%d.%d.%d", red + i, green + i*2, blue + i),
                          color: Color(red: Double(red + i) / 255.0, green: Double(green + i*2)/255.0, blue: Double(blue + i)/255.0),
                          scale: 2)
            )
        }
        
        self.zIndexPreset = (1...self.chipShapes.count).map({ value in Double(value) / Double(360) }).reversed()
    }
    
    @State var delta: Double = 0
    @State var currentAngle: Double = 0
    @State var currentCard: Int = 0
    @State var isDragging = false
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged{ val in
                isDragging = true
                delta = val.translation.width
                
                let tempCurrentCard = -Int(round(Double(currentAngle + delta) / Double(360 / chipShapes.count))) % chipShapes.count
                
                withAnimation(.easeInOut(duration: 0.1)) {
                    if tempCurrentCard < 0 {
                        currentCard = tempCurrentCard + chipShapes.count
                    } else {
                        currentCard = tempCurrentCard
                    }
                }
            }
            .onEnded { val in
                isDragging = false
                currentAngle += delta
                currentAngle = Double((Int(currentAngle) % 360))
            }
        
        
        ZStack {
            let angleOffset: Double = -30

            ForEach(0 ..< chipShapes.count) { index in
                let relativeIndex =
                index - currentCard < 0 ? (index - currentCard + chipShapes.count) : (index - currentCard)
      
                let correctdRelativeIndex = relativeIndex + chipShapes.count/2 >= chipShapes.count ? relativeIndex + chipShapes.count/2 - chipShapes.count : relativeIndex + chipShapes.count/2
                
                ZStack(alignment: .top) {
                    chipShapes[index]
                        .offset(y: currentCard == index ? 100 : 0)
                    
                    ZStack(alignment: .bottomTrailing) {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 57*2.5, height: 90*1.5)
                        }
                        Text(String(index+1))
                            .font(Font.custom("HelveticaNeue-Bold", size: 15))
                            .rotationEffect(.degrees(90))
                            .padding(10)
                    }
                    .zIndex(1)
                }
                .rotationEffect(.degrees(0))
                .rotation3DEffect(
                    .degrees(angleOffset + (Double(360 / chipShapes.count) * Double(index) +
                                       (isDragging ? currentAngle + delta : currentAngle))),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: UnitPoint(x: -2, y: -1.5),
                    perspective: 0.1)
                .zIndex(zIndexPreset[correctdRelativeIndex])
            }
            .shadow(radius: 5, x: 5, y: 0)
            .offset(x: 0)
            .gesture(dragGesture)
        }
    }
}

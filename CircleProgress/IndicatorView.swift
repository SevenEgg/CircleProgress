//
//  IndicatorView.swift
//  CircleProgress
//
//  Created by Yali on 2024/11/4.
//

import SwiftUI

struct IndicatorView: View {
    @State var progress: CGFloat = 0
    @State var displayedProgress: CGFloat = 0
    
    var body: some View {
        VStack{
            indicatorProgressView(progress: progress, totalSteps: 1000, minValue: 0, maxValue: 1000)
                .padding()
            
            Button {
                withAnimation(.spring(duration: 1,bounce: 0.2,blendDuration: 0.1)){
                    progress = CGFloat.random(in: 0...1000)
                }
            } label: {
                Text("Randomize Progress")
            }
            
        }
    }
}


struct indicatorProgressView: View {
    var progress: CGFloat
    var totalSteps: Int
    var minValue: CGFloat
    var maxValue: CGFloat
    var tickInterval: CGFloat = 50
    
    var body: some View {
        ZStack{
            
            HalfCircleShape()
                .stroke(lineWidth: 20)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.green,.orange,.red]), startPoint: .leading, endPoint: .trailing))
                .opacity(0.9)
                .frame(width: 200,height: 100)
            
            VStack{
                Text("\(Int((progress / maxValue) * 100)) %")
                    .font(.largeTitle.bold())
            }
            .offset(y:-40)
            
            Rectangle()
                .foregroundStyle(.red)
                .frame(width: 2,height: 100)
                .offset(y:-50)
                .rotationEffect(.degrees(180 * normalizedProgress))
                .rotationEffect(.degrees(-90))
            
            Circle()
                .frame(width: 15,height: 15)
                .foregroundStyle(.red.gradient)
            
            ForEach(0..<Int(maxValue / tickInterval) + 1,id: \.self) { index in
                Rectangle()
                    .frame(width:1.5, height: index % 2 == 0 ? 10 : 5)
                    .offset(y: index % 2 == 0 ? -85 : -87)
                    .rotationEffect(Angle(degrees: 89))
                    .rotationEffect(Angle(degrees: -Double(index) * (178 / Double(maxValue / tickInterval))))
            }
            
            
            
        }
    }
    
    private var normalizedProgress: CGFloat {
        (progress - minValue) / (maxValue - minValue)
    }
}


#Preview {
    IndicatorView()
}

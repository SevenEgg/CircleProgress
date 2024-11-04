//
//  ContentView.swift
//  CircleProgress
//
//  Created by Yali on 2024/11/4.
//

import SwiftUI

struct ContentView: View {
    @State var progress: CGFloat = 0
    @State var displayedProgress: CGFloat = 0
    
    var body: some View {
        VStack {
            HalfCircleProgressView(progress: progress, totalSteps: 500, minValue: 0, maxValue: 500)
            Button {
                let newProgress = CGFloat.random(in: 0..<500)
                withAnimation {
                    startIncrementing(to: newProgress)
                }
                
            } label: {
                Text("Randomize Progress")
            }
        }
        .padding()
        
    }
    
    func startIncrementing(to targetValue: CGFloat) {
        let step: CGFloat = targetValue > displayedProgress ? 1 : -1
        
        Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true) { timer in
            if (step > 0 && displayedProgress < targetValue) || (step < 0 && displayedProgress > targetValue) {
                displayedProgress += step
                progress = displayedProgress
            } else {
                timer.invalidate()
                displayedProgress = targetValue
                progress = displayedProgress
            }
        }
        
    }
    
}


struct HalfCircleProgressView:View {
    var progress: CGFloat
    var totalSteps: Int
    var minValue: CGFloat
    var maxValue: CGFloat
    
    var body: some View {
        ZStack{
            HalfCircleShape()
                .stroke(style: StrokeStyle(lineWidth: 20,lineCap: .round,lineJoin: .round))
                .foregroundStyle(.gray.opacity(0.3))
                .frame(width: 200,height: 200)
            
            HalfCircleShape()
                .trim(from: 0.0,to: normalizedProgress)
                .stroke(style: StrokeStyle(lineWidth: 20,lineCap: .round,lineJoin: .round))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue,.indigo]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 200,height: 200)
            
            VStack{
                Text("\(Int((progress / maxValue) * 100)) %")
                    .font(.largeTitle.bold())
                Text("\(remainningSteps) steps left")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        
        }
    }
    
    private var normalizedProgress: CGFloat {
        (progress - minValue) / (maxValue - minValue)
    }
    
    private var inProgress: Int {
        return max(0,totalSteps - Int(progress))
    }
    
    private var remainningSteps: Int {
        return max(0,totalSteps - Int(progress))
    }
    
}

struct HalfCircleShape: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center:CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 0),
                    clockwise: false
        )
        
        return path
    }
}


#Preview {
    ContentView()
}

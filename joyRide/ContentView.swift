//
//  ContentView.swift
//  joyRide
//
//  Created by Eric Wang on 12/25/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var show = false
    @State var beta = false
    let title = "TrackMate"
    private var initialDelays = [0.0, 0.04, 0.012, 0.18, 0.28, 0.35]
    
    var body: some View {
        VStack {
            // Animated Title
            ZStack {
                ZStack {
                    AnimatedTitleView(
                        title: title,
                        color: Color(red: 0.07, green: 0.121, blue: 0.27),
                        initialDelay: initialDelays[5],
                        animationType: .spring(duration: 1)
                    )
                    AnimatedTitleView(
                        title: title,
                        color: Color(red: 0.13, green: 0.22, blue: 0.44),
                        initialDelay: initialDelays[4],
                        animationType: .spring(duration: 1)
                    )
                    AnimatedTitleView(
                        title: title,
                        color: Color(red: 0.8, green: 0.12, blue: 0.286),
                        initialDelay: initialDelays[3],
                        animationType: .spring(duration: 1)
                    )
                    AnimatedTitleView(
                        title: title,
                        color: Color(red: 1.0, green: 0.79, blue: 0.02),
                        initialDelay: initialDelays[2],
                        animationType: .spring(duration: 1)
                    )
                    AnimatedTitleView(
                        title: title,
                        color: Color(red: 0.07, green: 0.121, blue: 0.27),
                        initialDelay: initialDelays[1],
                        animationType: .spring(duration: 1)
                    )
                }
                AnimatedTitleView(
                    title: title,
                    color: Color(red: 0.13, green: 0.22, blue: 0.44),
                    initialDelay: initialDelays[0],
                    animationType: .spring
                )
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    withAnimation {
                        beta = true
                    }
                }
            }
            
            // Spacer for Beta Text
            Text("Beta version: 1.0")
                .foregroundStyle(Color(red: 0.13, green: 0.22, blue: 0.44))
                .opacity(beta ? 1 : 0) // Change opacity without affecting layout
                .animation(.easeInOut, value: beta)
                .padding(.top, 20) // Add padding for spacing
        }
    }
}


#Preview {
    ContentView()
}

struct AnimatedTitleView: View {
    let title: String
    let color: Color
    let initialDelay: Double
    let animationType: Animation
    @State private var show = false
    private var delayStep = 0.1
    
    init(title: String, color: Color, initialDelay: Double, animationType: Animation) {
        self.title = title
        self.color = color
        self.initialDelay = initialDelay
        self.animationType = animationType
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<title.count, id:\.self) { index in
                Text(String(title[title.index(title.startIndex, offsetBy: index)]))
                    .font(.system(size: 70))
                    .opacity(show ? 1 : 0)
                    .offset(y: show ? -30 : 30)
                    .animation(animationType.delay(Double(index) * delayStep + initialDelay), value: show)
                    .foregroundStyle(color)
            }
        }
        .onAppear() {
            show.toggle()
        }
    }
}

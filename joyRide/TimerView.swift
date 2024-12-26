//
//  TimerView.swift
//  joyRide
//
//  Created by Eric Wang on 12/26/24.
//

import SwiftUI

struct TimerView: View {
    let road: Road
    @State private var elapsedTime: TimeInterval = 0
    @State private var isRunning = false
    @State private var currentSection = 0
    @State private var sectionTimes: [Double] = []
    @State private var timer: Timer?
    
    var visibleSections: [Int] {
        let totalSections = min(6, road.sections)
        let start = max(0, min(currentSection - 2, road.sections - totalSections))
        return Array(start..<start + totalSections)
    }
    
    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        let milliseconds = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Larger Timer Display
            Text(formattedTime)
                .font(.system(size: 80, weight: .medium, design: .monospaced))
                .foregroundStyle(.white)
                .padding(.vertical, 40)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.18, green: 0.18, blue: 0.18))
            
            // Section Times Table with matching background
            List {
               ForEach(Array(0..<road.sections).sorted {
                   abs($0 - currentSection) < abs($1 - currentSection)
               }, id: \.self) { section in
                   HStack {
                       Text("Section \(section + 1)")
                           .fontWeight(.bold)
                       Spacer()
                       if section < sectionTimes.count {
                           Text(String(format: "%.2f", sectionTimes[section]))
                           Text("+0.00")
                               .foregroundStyle(.red)
                       } else {
                           Text("--:--.--")
                       }
                   }
                   .listRowBackground(
                       Color(red: 0.18, green: 0.18, blue: 0.18)
                           .opacity(section == currentSection ? 1.0 :
                               max(0.3, 1.0 - Double(abs(section - currentSection)) * 0.2))
                   )
                   .foregroundStyle(.white)
                   .opacity(section == currentSection ? 1.0 :
                       max(0.4, 1.0 - Double(abs(section - currentSection)) * 0.2))
               }
           }
           .listStyle(.plain)
           .scrollContentBackground(.hidden)
           .background(Color(red: 0.18, green: 0.18, blue: 0.18))
           .animation(.easeInOut, value: currentSection)
       }
        .background(Color(red: 0.18, green: 0.18, blue: 0.18))
        .navigationTitle(road.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            elapsedTime += 0.01
        }
    }

    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
}

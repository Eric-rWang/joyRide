//
//  joyRideApp.swift
//  joyRide
//
//  Created by Eric Wang on 12/25/24.
//

import SwiftUI

@main
struct joyRideApp: App {
    @State var show = false
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                if show {
                    HomeView()
                } else {
                    ContentView()
                }
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                    withAnimation {
                        show = true
                    }
                }
            }
        }
    }
}

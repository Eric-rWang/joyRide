//
//  ContentView.swift
//  joyRide
//
//  Created by Eric Wang on 12/25/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let manager = CLLocationManager()
    
    var body: some View {
        RoadListView()
            .onAppear {
                manager.requestWhenInUseAuthorization()
            }
    }
}

#Preview {
    ContentView()
}

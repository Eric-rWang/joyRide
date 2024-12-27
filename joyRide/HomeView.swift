//
//  HomeView.swift
//  joyRide
//
//  Created by Eric Wang on 12/26/24.
//

import SwiftUI
import MapKit

struct HomeView: View {
    let manager = CLLocationManager()
    
    var body: some View {
        RoadListView()
            .onAppear {
                manager.requestWhenInUseAuthorization()
            }
    }
}

#Preview {
    HomeView()
}

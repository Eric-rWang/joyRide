//
//  RoadMapView.swift
//  joyRide
//
//  Created by Eric Wang on 12/25/24.
//

import SwiftUI
import MapKit

struct RoadMapView: View {
    let road: Road
    @State private var region: MKCoordinateRegion
    @State private var route: MKRoute?

    init(road: Road) {
        self.road = road
        // Initialize region with default coordinates or road's start coordinate
        _region = State(initialValue: MKCoordinateRegion(
            center: road.startCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Map view at the top
                Map {
                    if let route = route {
                        MapPolyline(route.polyline)
                            .stroke(.blue, lineWidth: 5)
                    }
                    // Start marker with checkered flag
                    Annotation("Start", coordinate: road.startCoordinate) {
                        Image(systemName: "flag.checkered")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.black)
                    }
                    
                    // Finish marker with checkered flag
                    Annotation("Finish", coordinate: road.endCoordinate) {
                        Image(systemName: "flag.checkered")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.black)
                    }
                }
                .frame(height: geometry.size.height * 0.6) // Larger portion for the map
                .ignoresSafeArea(edges: [.horizontal])
                
                // Road information below the map
                VStack(alignment: .leading, spacing: 8) {
                    Text(road.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Length: \(road.length) miles")
                    Text(road.jobTitle)
                }
                .padding()
                
                Spacer()
            }
        }
        .navigationTitle(road.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            calculateRoute()
        }
    }

    func calculateRoute() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: road.startCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: road.endCoordinate))
        
        Task {
            let directions = MKDirections(request: request)
            if let response = try? await directions.calculate() {
                route = response.routes.first
                if let rect = route?.polyline.boundingMapRect {
                    region = MKCoordinateRegion(rect)
                }
            }
        }
    }
}

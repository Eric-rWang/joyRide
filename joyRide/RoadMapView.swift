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
                VStack(spacing: 16) {
                    // Road details
                    VStack(alignment: .leading, spacing: 12) {
                        Text(road.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(
                                red: 0.95,
                                green: 0.95,
                                blue: 0.95)
                            )
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                InfoRow(label: "Length", value: "\(road.length) miles")
                                InfoRow(label: "Sections", value: "\(road.sections)")
                                InfoRow(label: "Type", value: road.jobTitle)
                            }
                            
                            Spacer()
                            
//                            VStack(alignment: .trailing) {
//                                Text("Personal Best")
//                                    .font(.subheadline)
//                                    .foregroundStyle(Color(
//                                        red: 0.75,
//                                        green: 0.75,
//                                        blue: 0.75)
//                                    )
//                                Text(road.formattedBestTime)
//                                    .font(.title3)
//                                    .foregroundStyle(Color(
//                                        red: 0.95,
//                                        green: 0.95,
//                                        blue: 0.95)
//                                    )
//                            }
                        }
                    }
                    .padding()
                    .background(Color(red: 0.35, green: 0.40, blue: 0.40))
                    .cornerRadius(14)
                    
                    Spacer()
                    
                    // Start Engine button
                    NavigationLink(destination: TimerView(road: road)) {
                        Text("ENGINE\nSTART")
                            .font(.system(size: 18, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .frame(width: 100, height: 100)
                            .background(
                                Circle()
                                    .fill(Color(red: 0.94, green: 0.1, blue: 0.176))
                                    .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 2)
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.1), lineWidth: 2)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.black.opacity(0.2), lineWidth: 4)
                                            .blur(radius: 2)
                                            .offset(y: 2)
                                    )
                            )
                            .padding(.bottom, 30)
                    }

                }
                .padding()
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


struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(Color(
                    red: 0.85,
                    green: 0.85,
                    blue: 0.85)
                )
            Text(value)
                .foregroundStyle(Color(
                    red: 0.65,
                    green: 0.65,
                    blue: 0.65)
                )
        }
    }
}

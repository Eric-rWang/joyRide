//
//  RoadCardView.swift
//  joyRide
//
//  Created by Eric Wang on 12/25/24.
//

import SwiftUI

struct RoadCardView: View {
    let road: Road
    
    var body: some View {
        VStack {
            ZStack {
                Image(road.headerImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .clipped()
            }
            .overlay(alignment: .topLeading) {
                
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    // ?
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                        .padding(6)
                }
            }
            
            HStack {
                HStack {
                    Text(road.name)
                        .fontWeight(.bold)
                    
                    Text("· \(road.length) miles")
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
                
                Button {
                    // ?
                } label: {
                    Text("Start Tracking")
                        .padding(.vertical, 4)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                        .overlay {
                            Capsule()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(.gray)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .padding()
            }
        }
    }
}

struct RoadCardView_Previews: PreviewProvider {
    static var previews: some View {
        RoadCardView(road: road1)
            .previewLayout(.sizeThatFits)
    }
}


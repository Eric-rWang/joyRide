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
            
            HStack {
                VStack {
                    HStack {
                        Text(road.name)
                            .fontWeight(.bold)
                            .font(.custom("MyCustomFont", size: 16))
                            .foregroundStyle(Color(
                                red: 0.95,
                                green: 0.95,
                                blue: 0.95)
                            )
                        
                        Text("·  \(road.length) mi")
                            .font(.custom("MyCustomFont", size: 14))
                            .foregroundStyle(Color(
                                red: 0.75,
                                green: 0.75,
                                blue: 0.75)
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    Text(road.jobTitle)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .font(.custom("MyCustomFont", size: 14))
                        .padding(.vertical, 0.1)
                        .foregroundStyle(Color(
                            red: 0.85,
                            green: 0.85,
                            blue: 0.85)
                        )
                }
                .padding()
                
//                VStack {
//                    Text("Personal Best")
//                        .font(.custom("MyCustomFont", size: 16))
//                        .foregroundStyle(Color(
//                            red: 0.85,
//                            green: 0.85,
//                            blue: 0.85)
//                        )
//                        .padding(.horizontal)
//                    Text("\(road.formattedBestTime)")
//                        .font(.custom("MyCustomFont", size: 18))
//                        .foregroundStyle(Color(
//                            red: 0.85,
//                            green: 0.85,
//                            blue: 0.85)
//                        )
//                        .padding(.horizontal)
//                }
//                .frame(alignment: .topTrailing)
//                .padding()
            }
        }
        .background(Color(red: 0.35, green: 0.40, blue: 0.40))
        .cornerRadius(14)
    }
}

struct RoadCardView_Previews: PreviewProvider {
    static var previews: some View {
        RoadCardView(road: roadData[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

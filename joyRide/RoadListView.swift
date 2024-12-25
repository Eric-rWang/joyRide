//
//  RoadListView.swift
//  joyRide
//
//  Created by Eric Wang on 12/25/24.
//

import SwiftUI

struct RoadListView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(roadData) { row in
                    RoadCardView(road: row)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .overlay {
                            NavigationLink {
                                RoadMapView(road: row)
                            } label: {
                                EmptyView()
                            }
                            .opacity(0)
                        }
                }
            }
            .listStyle(.plain)
            .buttonStyle(.plain)
            .navigationTitle("Roads")
        }
    }
}

#Preview {
    RoadListView()
}

//
//  ContentView.swift
//  joyRide
//
//  Created by Eric Wang on 12/25/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("joyRide")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)
            
            Text("Roads currently available")
                .font(.system(size: 18))
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ContentView()
}

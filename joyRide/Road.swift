//
//  Road.swift
//  joyRide
//
//  Created by Eric Wang on 12/25/24.
//

import Foundation
import CoreLocation

struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int
}

struct Road: Identifiable {
    let id = UUID()
    let headerImage: String
    let name: String
    let length: Int
    let sections: Int
    let jobTitle: String
    let bestTime: Time
    let startCoordinate: CLLocationCoordinate2D
    let endCoordinate: CLLocationCoordinate2D
    
    var formattedBestTime: String {
       let hours = bestTime.hours > 0 ? "\(bestTime.hours)h " : ""
       let minutes = bestTime.minutes > 0 || bestTime.hours > 0 ? "\(bestTime.minutes)m " : ""
       let seconds = "\(bestTime.seconds)s"
       return hours + minutes + seconds
    }
}

let roadData = [
    Road(headerImage: "limecreek",
         name: "Lime Creek",
         length: 9,
         sections: 11,
         jobTitle: "Thrilling Twists & Turns",
         bestTime: Time(hours: 0, minutes: 15, seconds: 30),
         startCoordinate: CLLocationCoordinate2D(latitude: 30.44302, longitude: -97.91162),
         endCoordinate: CLLocationCoordinate2D(latitude: 30.48500, longitude: -97.86798)
        ),
    Road(headerImage: "oldspicewood",
         name: "Old Spicewood",
         length: 3,
         sections: 6,
         jobTitle: "Short & Sweet",
         bestTime: Time(hours: 0, minutes: 5, seconds: 45),
         startCoordinate: CLLocationCoordinate2D(latitude: 30.4218, longitude: -97.79456),
         endCoordinate: CLLocationCoordinate2D(latitude: 30.38346, longitude: -97.77156)
        )
]

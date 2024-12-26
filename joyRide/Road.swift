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
    let sectionEndCoordinates: [CLLocationCoordinate2D]
    
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
         sections: 10,
         jobTitle: "Thrilling Twists & Turns",
         bestTime: Time(hours: 0, minutes: 15, seconds: 30),
         startCoordinate: CLLocationCoordinate2D(latitude: 30.44302, longitude: -97.91162),
         endCoordinate: CLLocationCoordinate2D(latitude: 30.48500, longitude: -97.86798),
         sectionEndCoordinates: [
            CLLocationCoordinate2D(latitude: 30.449509, longitude: -97.90467),
             CLLocationCoordinate2D(latitude: 30.45488, longitude: -97.91363),
             CLLocationCoordinate2D(latitude: 30.46045, longitude: -97.91274),
             CLLocationCoordinate2D(latitude: 30.46035, longitude: -97.90595),
             CLLocationCoordinate2D(latitude: 30.46912, longitude: -97.90534),
             CLLocationCoordinate2D(latitude: 30.46766, longitude: -97.89760),
             CLLocationCoordinate2D(latitude: 30.47311, longitude: -97.89813),
             CLLocationCoordinate2D(latitude: 30.48011, longitude: -97.89749),
             CLLocationCoordinate2D(latitude: 30.48737, longitude: -97.89067)
         ]
        ),
    Road(headerImage: "oldspicewood",
         name: "Old Spicewood",
         length: 3,
         sections: 5,
         jobTitle: "Short & Sweet",
         bestTime: Time(hours: 0, minutes: 5, seconds: 45),
         startCoordinate: CLLocationCoordinate2D(latitude: 30.4218, longitude: -97.79456),
         endCoordinate: CLLocationCoordinate2D(latitude: 30.38346, longitude: -97.77156),
         sectionEndCoordinates: [
            CLLocationCoordinate2D(latitude: 30.413790, longitude: -97.79348),
             CLLocationCoordinate2D(latitude: 30.40672, longitude: -97.78990),
             CLLocationCoordinate2D(latitude: 30.39775, longitude: -97.78108),
             CLLocationCoordinate2D(latitude: 30.39089, longitude: -97.77590)
         ]
        ),
    Road(headerImage: "home",
         name: "Home",
         length: 1,
         sections: 3,
         jobTitle: "Just for Testing",
         bestTime: Time(hours: 0, minutes: 1, seconds: 0),
         startCoordinate: CLLocationCoordinate2D(latitude: 30.43558, longitude: -97.82297),
         endCoordinate: CLLocationCoordinate2D(latitude: 30.43671, longitude: -97.82215),
         sectionEndCoordinates: [
            CLLocationCoordinate2D(latitude: 30.43555, longitude: -97.82251),
            CLLocationCoordinate2D(latitude: 30.43626, longitude: -97.82230)
         ]
        )
]

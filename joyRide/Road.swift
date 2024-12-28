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
         bestTime: Time(hours: 0, minutes: 0, seconds: 0),
         startCoordinate: CLLocationCoordinate2D(latitude: 30.443017252863697, longitude: -97.91160227837274),
         endCoordinate: CLLocationCoordinate2D(latitude: 30.486051847008323, longitude: -97.86665165992635),
         sectionEndCoordinates: [
            CLLocationCoordinate2D(latitude: 30.44950469042202, longitude: -97.90467473741548),
            CLLocationCoordinate2D(latitude: 30.454876207999508, longitude: -97.91363459367729),
            CLLocationCoordinate2D(latitude: 30.460462019779193, longitude: -97.91279002348332),
            CLLocationCoordinate2D(latitude: 30.460419282011557, longitude: -97.90597786120328),
            CLLocationCoordinate2D(latitude: 30.469230588743617, longitude: -97.905635311562),
            CLLocationCoordinate2D(latitude: 30.46769827061085, longitude: -97.89769995888017),
            CLLocationCoordinate2D(latitude: 30.473089323895717, longitude: -97.89812364903021),
            CLLocationCoordinate2D(latitude: 30.480166634312198, longitude: -97.89750495040339),
            CLLocationCoordinate2D(latitude: 30.487481350005233, longitude: -97.89068932580112)
         ]
        ),
    Road(headerImage: "cocos",
         name: "Lime Creek @ Coco",
         length: 9,
         sections: 10,
         jobTitle: "We Love Coco",
         bestTime: Time(hours: 0, minutes: 0, seconds: 0),
         startCoordinate: CLLocationCoordinate2D(latitude: 30.486051847008323, longitude: -97.86665165992635),
         endCoordinate: CLLocationCoordinate2D(latitude: 30.443017252863697, longitude: -97.91160227837274),
         sectionEndCoordinates: [
            CLLocationCoordinate2D(latitude: 30.487481350005233, longitude: -97.89068932580112),
            CLLocationCoordinate2D(latitude: 30.480166634312198, longitude: -97.89750495040339),
            CLLocationCoordinate2D(latitude: 30.473089323895717, longitude: -97.89812364903021),
            CLLocationCoordinate2D(latitude: 30.46769827061085, longitude: -97.89769995888017),
            CLLocationCoordinate2D(latitude: 30.469230588743617, longitude: -97.905635311562),
            CLLocationCoordinate2D(latitude: 30.460419282011557, longitude: -97.90597786120328),
            CLLocationCoordinate2D(latitude: 30.460462019779193, longitude: -97.91279002348332),
            CLLocationCoordinate2D(latitude: 30.454876207999508, longitude: -97.91363459367729),
            CLLocationCoordinate2D(latitude: 30.44950469042202, longitude: -97.90467473741548),
         ]
        ),
    Road(headerImage: "oldspicewood",
         name: "Old Spicewood",
         length: 3,
         sections: 5,
         jobTitle: "Short & Sweet",
         bestTime: Time(hours: 0, minutes: 0, seconds: 0),
         startCoordinate: CLLocationCoordinate2D(latitude: 30.421536354097064, longitude: -97.79429454428325),
         endCoordinate: CLLocationCoordinate2D(latitude: 30.38386541720474, longitude: -97.77144110042585),
         sectionEndCoordinates: [
            CLLocationCoordinate2D(latitude: 30.41383482975752, longitude: -97.79344216792988),
            CLLocationCoordinate2D(latitude: 30.406658697932862, longitude: -97.7899615053321),
            CLLocationCoordinate2D(latitude: 30.397814990863033, longitude: -97.78104747714116),
            CLLocationCoordinate2D(latitude: 30.390918252720322, longitude: -97.7758966566319)
         ]
        ),
    Road(headerImage: "oldspice360",
         name: "Old Spicewood @ 360",
         length: 3,
         sections: 5,
         jobTitle: "Short & Sweet",
         bestTime: Time(hours: 0, minutes: 0, seconds: 0),
         startCoordinate: CLLocationCoordinate2D(latitude: 30.38386541720474, longitude: -97.77144110042585),
         endCoordinate: CLLocationCoordinate2D(latitude: 30.421536354097064, longitude: -97.79429454428325),
         sectionEndCoordinates: [
            CLLocationCoordinate2D(latitude: 30.390918252720322, longitude: -97.7758966566319),
            CLLocationCoordinate2D(latitude: 30.397814990863033, longitude: -97.78104747714116),
            CLLocationCoordinate2D(latitude: 30.406658697932862, longitude: -97.7899615053321),
            CLLocationCoordinate2D(latitude: 30.41383482975752, longitude: -97.79344216792988),
         ]
        ),
    Road(headerImage: "home",
         name: "Home",
         length: 1,
         sections: 3,
         jobTitle: "Just for Testing",
         bestTime: Time(hours: 0, minutes: 0, seconds: 0),
         startCoordinate: CLLocationCoordinate2D(latitude: 30.43666, longitude: -97.82132),
         endCoordinate: CLLocationCoordinate2D(latitude: 30.43324, longitude: -97.81825),
         sectionEndCoordinates: [
            CLLocationCoordinate2D(latitude: 30.43696, longitude: -97.81761),
            CLLocationCoordinate2D(latitude: 30.43481, longitude: -97.81681)
         ]
        )
]

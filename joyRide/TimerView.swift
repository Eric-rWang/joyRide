//
//  TimerView.swift
//  joyRide
//
//  Created by Eric Wang on 12/26/24.
//

import SwiftUI
import MapKit
import CoreLocation
import UniformTypeIdentifiers

class LocationDelegate: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var onLocationUpdate: ((CLLocation) -> Void)?
    @Published var onStartCross: (() -> Void)?
    @Published var onFinishCross: (() -> Void)?
    @Published var currentSpeed: Double = 0
    @Published var onSectionCheck: ((CLLocation) -> Void)?
    var startCoordinate: CLLocationCoordinate2D
    var endCoordinate: CLLocationCoordinate2D
    
    init(startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D) {
        self.startCoordinate = startCoordinate
        self.endCoordinate = endCoordinate
        super.init()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            onLocationUpdate?(location)
            
            // Speed calculation
            let speedMPS = location.speed
            if speedMPS > 0 {
                currentSpeed = speedMPS * 2.23694
            }
            
            // Start line check
            let startDistance = location.coordinate.distance(to: startCoordinate)
            if startDistance < 15 {
                onStartCross?()
            }
            
            // Section check
            onSectionCheck?(location)
            
            // Finish line check
            let finishDistance = location.coordinate.distance(to: endCoordinate)
            if finishDistance < 15 {
                onFinishCross?()
        }
    }
}

class TimerManager: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    private var startDate: Date?
    private var timer: Timer?
    
    func start() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self = self,
                  let start = self.startDate else { return }
            self.elapsedTime = Date().timeIntervalSince(start)
        }
    }
    
    func stop() {
        startDate = nil
        timer?.invalidate()
        timer = nil
    }
}

struct RunResults: Codable {
    let roadName: String
    let date: Date
    let totalTime: TimeInterval
    let sectionResults: [SectionResult]
    
    struct SectionResult: Codable {
        let section: Int
        let time: Double
        let speed: Double
    }
}

struct TextFile: FileDocument {
    static var readableContentTypes = [UTType.plainText]
    var text: String
    
    init(initialText: String = "") {
        text = initialText
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            text = ""
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}


struct TimerView: View {
    let road: Road
    @StateObject private var locationDelegate: LocationDelegate
    @State private var elapsedTime: TimeInterval = 0
    @State private var isRunning = false
    @State private var currentSection = 0
    @State private var timer: Timer?
    @State private var locationManager = CLLocationManager()
    @State private var userCoordinates: [CLLocationCoordinate2D] = []
    @State private var sectionTimes: [TimeInterval] = []
    @State private var sectionStartTime: TimeInterval = 0
    @State private var startDate: Date?
    @StateObject private var timerManager = TimerManager()
    @State private var sectionSpeeds: [Double] = []
    @State private var showingSaveAlert = false
    @State private var sectionResults: [(section: Int, time: Double, speed: Double)] = []
    @State private var isExporting = false
    @State private var runDataToExport: RunResults?
    
    init(road: Road) {
        self.road = road
        _locationDelegate = StateObject(wrappedValue: LocationDelegate(
            startCoordinate: road.startCoordinate,
            endCoordinate: road.endCoordinate
        ))
    }
    
    var formattedTime: String {
        let minutes = Int(timerManager.elapsedTime) / 60
        let seconds = Int(timerManager.elapsedTime) % 60
        let milliseconds = Int((timerManager.elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    var visibleSections: [Int] {
        let totalSections = min(6, road.sections)
        let start = max(0, min(currentSection - 2, road.sections - totalSections))
        return Array(start..<start + totalSections)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Larger Timer Display
            Text(formattedTime)
                .font(.system(size: 80, weight: .medium, design: .monospaced))
                .foregroundStyle(.white)
                .padding(.vertical, 40)
                .frame(maxWidth: .infinity) // Ensures the text spans the entire available width
                .background(Color(red: 0.18, green: 0.18, blue: 0.18))
                .lineLimit(1) // Restrict text to one line
                .minimumScaleFactor(0.5)
            
            // Section Times Table with matching background
            List {
                ForEach(visibleSections, id: \.self) { section in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(section == road.sections - 1 ? "Finish" : "Section \(section + 1)")
                                .fontWeight(.bold)
                            if section < sectionSpeeds.count {
                                Text("\(Int(sectionSpeeds[section].rounded())) mph")
                                    .font(.subheadline)
                            }
                        }
                        Spacer()
                        if section < sectionTimes.count {
                            Text(String(format: "%02d:%02d.%02d",
                                Int(sectionTimes[section]) / 60,
                                Int(sectionTimes[section]) % 60,
                                Int((sectionTimes[section].truncatingRemainder(dividingBy: 1)) * 100)))
                        } else {
                            Text("--:--.--")
                        }
                    }
                    .listRowBackground(
                        Color(red: 0.35, green: 0.40, blue: 0.40)
                            .opacity(section == currentSection ? 1.0 : 0.4)
                    )
                    .foregroundStyle(.white)
                }
           }
           .listStyle(.plain)
           .scrollContentBackground(.hidden)
           .background(Color(red: 0.18, green: 0.18, blue: 0.18))
           .animation(.easeInOut, value: currentSection)
            Text("Current Speed: \(String(format: "%.1f", locationDelegate.currentSpeed)) mph")
                            .foregroundStyle(.white)
       }
        .background(Color(red: 0.18, green: 0.18, blue: 0.18))
        .navigationTitle(road.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setupLocationTracking()
        }
        .onDisappear {
            stopLocationTracking()
        }
        .alert("Save Run Results?", isPresented: $showingSaveAlert) {
            Button("Save") {
                isExporting = true
            }
            Button("Discard", role: .cancel) { }
        }
        .fileExporter(
            isPresented: $isExporting,
            document: createTextDocument(),
            contentType: .plainText,
            defaultFilename: sanitizeFilename("\(road.name)-\(Date().formatted(date: .numeric, time: .shortened))")
        ) { result in
            switch result {
            case .success(let url):
                print("Saved to \(url)")
            case .failure(let error):
                print("Error saving file: \(error.localizedDescription)")
            }
        }
        
//        Button("Test Save") {
//            // Create sample data
//            sectionTimes = [45.23, 62.45, 38.91]
//            sectionSpeeds = [65.4, 72.1, 68.3]
//            timerManager.elapsedTime = 146.59
//            currentSection = sectionTimes.count // Set current section to match data
//            showingSaveAlert = true
//        }
//        .padding()

    }
    
    func prepareRunDataString() -> String {
        var output = "Run Results for \(road.name)\n"
        output += "Date: \(Date().formatted())\n"
        output += "Total Time: \(formattedTime)\n\n"
        
        // Add section results
        for (index, (time, speed)) in zip(sectionTimes, sectionSpeeds).enumerated() {
            output += "Section \(index + 1):\n"
            output += String(format: "  Time: %02d:%02d.%02d\n",
                Int(time) / 60,
                Int(time) % 60,
                Int((time.truncatingRemainder(dividingBy: 1)) * 100))
            output += "  Speed: \(Int(speed.rounded())) mph\n\n"
        }
        
        return output
    }
    
    func createTextDocument() -> TextFile {
        let text = prepareRunDataString()
        return TextFile(initialText: text)
    }
    
    func setupLocationTracking() {
        locationManager.delegate = locationDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 0.5
        locationManager.activityType = .automotiveNavigation
//        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
        
        
        locationDelegate.onSectionCheck = { location in
            if isRunning {
                for (index, sectionEnd) in road.sectionEndCoordinates.enumerated() {
                    let distance = location.coordinate.distance(to: sectionEnd)
                    if distance < 25 && index == currentSection {
                        // Use timerManager.elapsedTime instead of elapsedTime
                        let sectionTime = timerManager.elapsedTime - sectionStartTime
                        sectionTimes.append(sectionTime)
                        sectionSpeeds.append(locationDelegate.currentSpeed)
                        sectionStartTime = timerManager.elapsedTime
                        currentSection += 1
                    }
                }
            }
        }
        
        locationDelegate.onStartCross = {
            if !isRunning {
                startTimer()
                sectionStartTime = timerManager.elapsedTime
            }
        }
        
        locationDelegate.onFinishCross = {
            // Record the final section time
            if isRunning {
                let finalTime = timerManager.elapsedTime - sectionStartTime
                sectionTimes.append(finalTime)
                sectionSpeeds.append(locationDelegate.currentSpeed)
                stopTimer() // Stop the timer
                
                // Delay showing save alert to ensure UI is ready
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showingSaveAlert = true
                }
            }
        }
    }
    
//    func checkSectionCrossing(at coordinate: CLLocationCoordinate2D) {
//        guard isRunning,
//              currentSection < road.sectionEndCoordinates.count else { return }
//        
//        let sectionEnd = road.sectionEndCoordinates[currentSection]
//        let distance = coordinate.distance(to: sectionEnd)
//        
//        if distance < 25 { // 10 meters threshold
//            // Save section time
//            sectionTimes.append(elapsedTime - sectionStartTime)
//            sectionStartTime = elapsedTime
//            
//            // Move to next section
//            currentSection += 1
//        }
//    }
    
    func startTimer() {
        isRunning = true
        timerManager.start()
    }
    
    func stopTimer() {
        isRunning = false
        timerManager.stop()
    }
    
    func stopLocationTracking() {
        locationManager.stopUpdatingLocation()
        stopTimer()
    }
    
    func sanitizeFilename(_ name: String) -> String {
        let invalidCharacters = CharacterSet(charactersIn: "/\\?%*|\"<>")
        return name.components(separatedBy: invalidCharacters).joined(separator: "-")
    }
    
    
}

extension CLLocationCoordinate2D {
    func distance(to coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let to = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return from.distance(from: to)
    }
}


//
//  DataModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/4/23.
//

import Foundation

@MainActor
class DataModel: ObservableObject {
    @Published var measurementSamples: [MeasurementSample] = []
    
    
    @Published var currentSampleInfoName: String = ""
    @Published var currentLocationInfoName: String = ""
    @Published var measurementNumber: Int = 1
    @Published var groupNumber: Int = 0
    
    var currentMeasurementGroup: MeasurementSample? {
        return measurementSamples.last
    }
    
    @Published var flattendMeasurements: [Measurement] = [] {
        didSet {
            print(flattendMeasurements.count)
        }
    }
    
    init() {
        self.registerForNotifications()
    }
    
    
    func addNewMeasurement(withValue measurement: Double) {
        if newMeasurementGroupNeeded() {
            self.createNewMeasurementGroup()
        }
        
        if newMeasurementLocationNeeded() {
            self.currentMeasurementGroup?.newLocation()
        }
        
        self.currentMeasurementGroup?.addMeasurement(measurement, withMeasurementNumber: measurementNumber)
        measurementNumber += 1
    }
    
    
    private func newMeasurementGroupNeeded() -> Bool {
        guard let lastGroup = currentMeasurementGroup else {
            return true
        }
        
        if lastGroup.sampleInfo.name != currentSampleInfoName {
            return true
        }
        
        return false
    }
    
    private func newMeasurementLocationNeeded() -> Bool {
        guard let lastGroup = currentMeasurementGroup else {
            return false
        }
        
        if lastGroup.location.name != currentLocationInfoName {
            return true
        }
        
        return false
    }
    
    
    private func createNewMeasurementGroup() {
        
        if newMeasurementGroupNeeded() {
            let newSampleInfo = SampleInfo(currentSampleInfoName)
            let newLocationInfo = LocationInfo(currentLocationInfoName)
            groupNumber += 1
            
            let newMeasurementGroup = MeasurementSample(sampleNumber: groupNumber, sampleInfo: newSampleInfo, location: newLocationInfo)
            measurementSamples.append(newMeasurementGroup)
        }
        
        
    }
    
}

// MARK: - Register for Notifications
extension DataModel {
    func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .newMeasurementAdded, object: nil, queue: nil, using: updateFlattenedMeasurement(_:))
    }
    
    func updateFlattenedMeasurement(_ notification: Notification) {
        var measurements: [Measurement] = []
        
        for nextGroup in measurementSamples {
            measurements.append(contentsOf: nextGroup.measurements)
        }
        
        flattendMeasurements =  measurements
    }
}

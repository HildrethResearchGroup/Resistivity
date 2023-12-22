//
//  DataModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/4/23.
//

import Foundation

@MainActor
class DataModel: ObservableObject {
    @Published var samples: [Sample] = []
    
   
    @Published var currentSampleInfoName: String = ""
    @Published var currentLocationInfoName: String = ""
    @Published var measurementNumber: Int = 1
    @Published var groupNumber: Int = 0
    
    
    
    var currentMeasurementGroup: Sample? {
        return samples.last
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
            
            // TODO: Fix
            let newMeasurementGroup = Sample(sampleNumber: <#T##Int#>, sampleInfo: <#T##SampleInfo#>, location: <#T##Location#>)
            
            let newSampleInfo = Sample(currentSampleInfoName, withLocationName: currentLocationInfoName)
            
            
            
            
            samples.append(newMeasurementGroup)
        }
        
        
    }
    
}

// MARK: - Register for Notifications
extension DataModel {
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .newMeasurementAdded, object: nil, queue: nil, using: updateFlattenedMeasurement(_:))
    }
    
    
    
    /// Updates the array of Flattened Measurements whenever a new measurement is created.  This function is triggered when the `newMeasurementAdded` notification is received.
    ///
    /// This function is marked as nonisolated becuase NotificationCenter's `addObserver` function requires an `@Sendable` clsoure.  Without making this function as `nonisolated`, the addObserver function results in a warning: "Converting function value of type '@MainActor (Notification) -> ()' to '@Sendable (Notification) -> Void' loses global actor 'MainActor'"
    ///
    /// - Parameter notification: newMeasurementAdded notification
    nonisolated private func updateFlattenedMeasurement(_ notification: Notification) {
        
        // Thie status must be updated within the updateFlattenedMeasurement closure.  However, updating the DataModel's flattendMeasurements must be done on the MainActor's thread since DataModel is marked as @MainActor
        
        Task {
            await MainActor.run {
                var measurements: [Measurement] = []
                
                for nextGroup in samples {
                    measurements.append(contentsOf: nextGroup.measurements)
                }
                
                flattendMeasurements =  measurements
            }
        }
    }
}

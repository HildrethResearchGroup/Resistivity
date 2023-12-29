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
    
    @Published var measurementNumber: Int = 1
    
    @Published var order: [KeyPathComparator<Measurement>] = [
               .init(\.globalMeasurementNumber, order: SortOrder.forward),
               .init(\.resistance, order: SortOrder.forward),
               .init(\.sampleInfo.name, order: SortOrder.forward),
               .init(\.locationInfo.name, order: SortOrder.forward),
               .init(\.sampleID, order: SortOrder.forward),
    ] {
        didSet {
            flattendMeasurements = flattendMeasurements.sorted(using: order)
        }
    }
    
    @Published var search: String = ""
    
    
    
    
    var currentSample: Sample? {
        return samples.last
    }
    
    
    @Published var flattendMeasurements: [Measurement] = []
    
    var filteredMeasurements: [Measurement] {
        return self.filterMeasurements(flattendMeasurements, withString: search)
    }
    
    var sortedMeasurements: [Measurement] {
        var localMeasurements = filteredMeasurements
        
        localMeasurements.sort(using: self.order)
        
        return localMeasurements
    }
    
    
    init() {
        self.registerForNotifications()
    }
    
    

    
    func addNewMeasurement(withValue measurement: Double, 
                           withSampleInfo sampleInfo: SampleInfo,
                           locationInfo: LocationInfo,
                           resistivityInfo: ResistivityMeasurementInfo,
                           lineResistanceInfo: LineResistanceInfo,
                           globalMeasurementNumber: Int) {
        
        if newSampleNeeded(sampleInfo) {
            self.createnewSample(withInfo: sampleInfo)
        }
        
        
        
        self.currentSample?.addMeasurement(measurement, 
                                           globalMeasurementNumber: globalMeasurementNumber,
                                           locationInfo: locationInfo, 
                                           resistivityInfo: resistivityInfo,
                                           lineResistanceInfo: lineResistanceInfo)

        measurementNumber += 1
    }
    
    
    private func newSampleNeeded(_ sampleInfo: SampleInfo) -> Bool {
        
        if currentSample?.info.name != sampleInfo.name {
            return true
        }
        
        return false
    }
    
    
    
    private func createnewSample(withInfo sampleInfo: SampleInfo) {
        
        if newSampleNeeded(sampleInfo) {
            let sampleNumber = samples.count + 1
            
            var sampleInfo = sampleInfo
            
            sampleInfo.sampleNumber = sampleNumber

            let newSample = Sample(sampleInfo)
            
            samples.append(newSample)
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
                
                for nextSample in samples {
                    measurements.append(contentsOf: nextSample.flattendMeasurements)
                }
                
                // measurements = filterMeasurements(measurements, withString: self.search)
                
                // measurements.sort(using: self.order)
                
                flattendMeasurements =  measurements
            }
        }
    }
    
    
    func filterMeasurements(_ measurementsIn: [Measurement], withString filterString: String) -> [Measurement] {
        return measurementsIn.filter({$0.contains(information: filterString)})
    }
}

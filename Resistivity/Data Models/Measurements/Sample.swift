//
//  MeasurementsViewModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation


class Sample {
    var id = UUID()
    var name: String
    let sampleNumber: Int
    
    var locations: [Location] = []
    
    var resistanceStatistics = Statistics<Measurement>(keyPath: \.resistance, name: "Resistance", units: "Ω")
    var resistivityStatistics = Statistics<Measurement>(keyPath: \.resistivity, name: "Resistivity", units: "Ω-m")
    
    
    // MARK: - Convienence Getters
    var flattendMeasurements: [Measurement] {
        get {
            return locations.flatMap { $0.measurements }
        }
    }
    
    var currentLocation: Location? {
        get {
            return locations.last
        }
    }
    
    var numberOfMeasurementsInSample: Int {
        return flattendMeasurements.count
    }
    
    // MARK: - Initializers
    init(sampleName: String, sampleNumber sampleNumberIn: Int, locationName: String) {
        name = sampleName
        sampleNumber = sampleNumberIn
        
        createNewLocation(withName: locationName)
    }
    
    
    // MARK: - Location Management
    private func isANewLocationNeeded(forName locationNameIn: String) -> Bool {
        guard let location = currentLocation else {
            return true
        }
        
        if location.name != locationNameIn {
            return true
        } else {
            return false
        }
    }
    
    private func createNewLocation(withName locationNameIn: String) {
        let newLocationNumber = locations.count + 1
        
        let newLocation = Location(withName: locationNameIn, withLocationNumber: newLocationNumber)
        
        locations.append(newLocation)
    }
    
    
    // TODO: Remove and move to locations
    /*
     var measurements: [Measurement] = [] {
         didSet {
             updateStatistics()
             NotificationCenter.default.post(name: .newMeasurementAdded, object: nil)
         }
     }
     */
    
    
    
    // let sampleInfo: SampleInfo
    // let location: Location
    
    //var locationNumber = 1
    //var localMeasurementNumber: Int = 0
    
    /*
     init(sampleNumber: Int, sampleInfo: SampleInfo, location: Location) {
         self.sampleNumber = sampleNumber
         self.sampleInfo = sampleInfo
         self.location = location
     }
     */
    
    
    
    
    private func updateStatistics() {
        let localMeasurements = flattendMeasurements
        resistanceStatistics.update(with: localMeasurements)
        resistivityStatistics.update(with: localMeasurements)
    }
    
    func addMeasurement(_ resistanceIn: Double, withGlobalMeasurementNumber: Int, locationName: String) {
        if self.isANewLocationNeeded(forName: locationName) {
            createNewLocation(withName: locationName)
        }
        
        let locationNumber = locations.count
        
        
        
        
        
    }
    
    
    
}

extension Sample {
    func save() {
        print("Save")
    }
}

extension Sample: Equatable {
    static func == (lhs: Sample, rhs: Sample) -> Bool {
        return lhs.id == rhs.id
    }
}


extension Notification.Name {
    static let newMeasurementAdded = Notification.Name("newMeasurementAdded")
}

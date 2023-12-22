//
//  LocationInformation.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

class Location {
    var id = UUID()
    var name = ""
    
    
    var locationNumber: Int = 0
    
    var measurements: [Measurement] = []
}


// MARK: - Common Conformances
extension Location: Identifiable, Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}


// MARK: - Initializers
extension Location {
    convenience init(withName nameIn: String, withLocationNumber locationNumberIn: Int) {
        self.init()
        name = nameIn
        
        locationNumber = locationNumberIn
    }
    
    convenience init(withSettings settings: LocationSettings) {
        self.init()
        
        name = settings.name
        locationNumber = settings.locationNumber
    }

}


// MARK: - Handling Measurements
extension Location {
    func addMeasurement(withResistance resistanceIn: Double, andGlobalNumber globalMeasurementIn: Int, sampleNumber: Int, withSampleName sampleName: String) {
        
        let localMeasurementNumber = self.measurements.count + 1
        
        let newMeasurement = Measurement(resistanceIn,
                                         globalMeasurementName: globalMeasurementIn,
                                         sampleNumber: sampleNumber,
                                         locationNumber: self.locationNumber,
                                         localMeasurementNumber: localMeasurementNumber,
                                         withSampleName: sampleName,
                                         andLocationName: self.name)
        
        measurements.append(newMeasurement)
    }
}

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
    
    
    convenience init(_ locationInfo: LocationInfo) {
        self.init(withName: locationInfo.name, withLocationNumber: locationInfo.locationNumber)
    }

}


// MARK: - Handling Measurements
extension Location {
    func addMeasurement(withResistance resistanceIn: Double, sampleInfo: SampleInfo, locationInfo: LocationInfo, globalMeasurementNumber: Int) {
        
        let localMeasurementNumber = self.measurements.count + 1
        
        let newMeasurement = Measurement(resistance: resistanceIn,
                                         sampleInfo: sampleInfo,
                                         locationInfo: locationInfo,
                                         globalMeasurementNumber: globalMeasurementNumber,
                                         locationMeasurementNumber: localMeasurementNumber)
        
        measurements.append(newMeasurement)
    }
}


extension Location: Info {
    typealias Output = LocationInfo
    
    func info() -> LocationInfo {
        return LocationInfo(name: self.name, locationNumber: self.locationNumber)
    }
}




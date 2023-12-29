//
//  LocationInformation.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

class Location {
    // MARK: - Properties
    var id = UUID()
    
    var info: LocationInfo

    var measurements: [Measurement] = [] {
        didSet {
            NotificationCenter.default.post(name: .newMeasurementAdded, object: nil)
        }
    }
    
    // MARK: - Initializers
    init(_ locationInfo: LocationInfo) {
        self.info = locationInfo
    }
}



// MARK: - Common Conformances
extension Location: Identifiable, Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}




// MARK: - Handling Measurements
extension Location {
    func addMeasurement(withResistance resistanceIn: Double, sampleInfo: SampleInfo, resistivityInfo: ResistivityMeasurementInfo, lineResistanceInfo: LineResistanceInfo, globalMeasurementNumber: Int) {
        
        info.measurementNumber += 1
        
        let newMeasurement = Measurement(resistance: resistanceIn,
                                         sampleInfo: sampleInfo,
                                         locationInfo: info,
                                         resistivityInfo: resistivityInfo,
                                         lineResistanceInfo: lineResistanceInfo,
                                         globalMeasurementNumber: globalMeasurementNumber)
        
        measurements.append(newMeasurement)
    }
}





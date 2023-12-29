//
//  Measurement.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation


struct Measurement {
    var id = UUID()
    let resistance: Double
    
    var sampleInfo: SampleInfo
    var locationInfo: LocationInfo
    
    var resistivityInfo: ResistivityMeasurementInfo
    var lineResistanceInfo: LineResistanceInfo
    
    var globalMeasurementNumber: Int
    // var sampleMeasurementNumber: Int
    // var locationMeasurementNumber: Int
    // var locationMeasurementNumber: Int
    
    
    let date: Date = .now
    let measurementDuration: Duration = .zero
    
    let resistivity = 0.0

}



// MARK: - Common Conformances
extension Measurement: Identifiable, Hashable {
    static func == (lhs: Measurement, rhs: Measurement) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


// MARK: - Calcualte Resistivity
extension Measurement {
    func calculateResistivity() -> Double {
        // TODO: Setup Resistivity Calculation
        return 0.0
    }
}

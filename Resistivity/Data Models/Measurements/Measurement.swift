//
//  Measurement.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation


struct Measurement {
    var id = UUID()
    var sampleInfo: Sample
    var locationInfo: Location
    var globalMeasurementNumber: Int
    var sampleMeasurementNumber: Int
    var locationMeasurementNumber: Int
    var localMeasurementNumber: Int
    
    let date: Date = .now
    let measurementDuration: Duration = .zero
    
    let resistance: Double
    
    
    let resistivity: Double = 0.0
    
    
    
    
    
}

// MARK - Intializers
extension Measurement {
    init(_ resistanceIn: Double, globalMeasurementName globalNumberIn: Int, sampleNumber: Int, locationNumber: Int, localMeasurementNumber: Int, withSampleName sampleNameIn: String, andLocationName locationNameIn: String) {
        resistance = resistanceIn
        globalMeasurementNumber = globalNumberIn
        
        
        sampleMeasurementNumber = sampleNumber
        locationMeasurementNumber = locationNumber
        self.localMeasurementNumber = localMeasurementNumber
        sampleName = sampleNameIn
        locationName = locationNameIn
    }
}


// MARK: - Common Conformances
extension Measurement: Identifiable, Hashable {
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

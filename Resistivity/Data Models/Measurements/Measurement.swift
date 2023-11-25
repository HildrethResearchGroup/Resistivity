//
//  Measurement.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation


struct Measurement {
    var id = UUID()
    let sampleInfo: SampleInfo
    let location: LocationInfo
    let globalMeasurementNumber: Int
    let sampleMeasurementNumber: Int
    let locationMeasurementNumber: Int
    let localMeasurementNumber: Int
    
    let date: Date = .now
    let measurementDuration: Duration = .zero
    
    let resistance: Double
    
    let shouldCalculateResistivity: Bool? = nil
    
    let resistivity: Double = 0.0
    
    let thickness: Double? = nil
    let thicknessCorrectionFactor: Double? = nil
    let finiteWidthCorrectionFactor: Double? = nil
    
    
}

// MARK - Intializers
extension Measurement {
    init(_ resistanceIn: Double, withGlobal globalNumberIn: Int, andSampleNumber sampleNumberIn: Int, andLocationMeasurementNumber locationMeasurementIn: Int, localMeasurementNumber: Int, atLocation locationIn: LocationInfo, withSampleInfo sampleInfoIn: SampleInfo) {
        resistance = resistanceIn
        globalMeasurementNumber = globalNumberIn
        sampleMeasurementNumber = sampleNumberIn
        locationMeasurementNumber = locationMeasurementIn
        self.localMeasurementNumber = localMeasurementNumber
        sampleInfo = sampleInfoIn
        location = locationIn
    }
}

extension Measurement: Identifiable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Measurement {
    func calculateResistivity() -> Double {
        // TODO: Setup Resistivity Calculation
        return 0.0
    }
}

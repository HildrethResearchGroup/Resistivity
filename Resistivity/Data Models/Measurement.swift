//
//  Measurement.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation


struct Measurement {
    let sampleInfo = SampleInfo()
    let location = LocationInfo()
    
    let date: Date = .now
    let measurementDuration: Duration
    
    let resistance: Double
    
    let shouldCalculateResistivity: Bool
    
    let resistivity: Double = 0.0
    
    let thickness: Double?
    let thicknessCorrectionFactor: Double?
    let finiteWidthCorrectionFactor: Double?
    
    
}

extension Measurement {
    func calculateResistivity() -> Double {
        // TODO: Setup Resistivity Calculation
        return 0.0
    }
}

//
//  MeasurementSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

struct ResistivityMeasurementSettings {
    var id = UUID()
    
    var shouldCalculateResistivity: Bool = false
    let thickness: Double = 1.0
    let thicknessCorrectionFactor: Double = 1.0
    let finiteWidthCorrectionFactor: Double = 1.0
}

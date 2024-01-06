//
//  ResistivityMeasurementInfo_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

/// Extension of `ResistivityMeasurementInfo` to conform to the `Exportable` protocol.
/// This allows instances of `ResistivityMeasurementInfo` to be exported with a standardized header and data representation.
extension ResistivityMeasurementInfo: Exportable {
    
    /// Generates a header for the CSV export.
    /// - Returns: An array of strings representing the column headers for the associated data.
    func header() -> [String] {
        return ["Should Calculate Resistivity",
                "Sample Thickness [m]",
                "Thickness Correction Factor",
                "Finite Width Correction Factor"
        ]
    }
    
    /// Generates the data for the CSV export.
    /// - Returns: An array of strings representing the values of the properties of `ResistivityMeasurementInfo`.
    func data() -> [String] {
        return [String(shouldCalculateResistivity),
                String(thickness),
                String(thicknessCorrectionFactor),
                String(finiteWidthCorrectionFactor)
        ]
    }
}

//
//  ResistivityMeasurementInfo_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

extension ResistivityMeasurementInfo: Exportable {
    func header() -> [String] {
        return ["Should Calculate Resistivity",
                "Sample Thickness [m]",
                "Thickness Correction Factor",
                "Finite Width Correction Factor"
        ]
    }
    
    func data() -> [String] {
        return [String(shouldCalculateResistivity),
                String(thickness),
                String(thicknessCorrectionFactor),
                String(finiteWidthCorrectionFactor)
        ]
    }
    
    
}

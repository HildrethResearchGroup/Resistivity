//
//  ResistivityMeasurementInfo.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation

struct ResistivityMeasurementInfo: Identifiable {
    var id = UUID()
    
    var shouldCalculateResistivity: Bool
    var thickness: Double
    var thicknessCorrectionFactor: Double
    var finiteWidthCorrectionFactor: Double
    
    // MARK: -
    private var t: Double { return thickness }
    private var f1: Double { return thicknessCorrectionFactor }
    private var f2: Double { return finiteWidthCorrectionFactor }
    
    func hasSameInformation(_ infoIn: ResistivityMeasurementInfo) -> Bool {
        
        if self.shouldCalculateResistivity != infoIn.shouldCalculateResistivity { return false }
        
        if self.thickness != infoIn.thickness { return false}
        
        if self.thicknessCorrectionFactor != infoIn.thicknessCorrectionFactor { return false }
        
        if self.finiteWidthCorrectionFactor != infoIn.finiteWidthCorrectionFactor { return false }
    }
}

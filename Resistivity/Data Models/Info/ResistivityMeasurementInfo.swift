//
//  ResistivityMeasurementInfo.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation

/// A structure that holds information necessary for calculating the resistivity of a material.
struct ResistivityMeasurementInfo: Identifiable {
    var id = UUID()
    
    /// A boolean indicating whether resistivity should be calculated.
    var shouldCalculateResistivity: Bool
    
    /// The thickness of the material for which resistivity is being calculated.
    var thickness: Double
    
    
    
    /// A geometric correction factor applied to account for the thickness of the material.
    ///
    /// If the sample being tested is thicker than 40% of the probe spacing, an additional correction factor is required. The correction factor used is dependent upon the ratio of the sample thickness (t) to the probe spacing (s) and some of the possible values are listed in the table found at: 
    /// [Ossila Sheet Resistance]( https://www.ossila.com/pages/sheet-resistance-theory)
    var thicknessCorrectionFactor: Double
    
    /// A correction factor applied to account for the finite width of the material.
    ///
    /// From: [Ossila Sheet Resistance]( https://www.ossila.com/pages/sheet-resistance-theory).
    /// Whilst the above equation for sheet resistance is independent of sample geometry, this only applies when the sample is significantly larger (typically having dimensions 40 times greater) than the spacing of the probes, and if the sample is thinner than 40% of the probe spacing. If this is not the case, the possible current paths between the probes are limited by the proximity to the edges of the sample, resulting in an overestimation of the sheet resistance. To account for this difference, a correction factor based upon the geometry of the sample is required.
    /// 
    /// All the correction factors in this guide were obtained from *Haldor Topsøe, Geometric Factors in Four Point Resistivity Measurement, 1966.*
    var finiteWidthCorrectionFactor: Double
    
    /// Compares this instance with another `ResistivityMeasurementInfo` instance to determine if they hold the same user-generated information.
    ///
    /// Note: It does not compare the UUID's since this is not user-generated information.
    /// - Parameter infoIn: The `ResistivityMeasurementInfo` instance to compare with.
    /// - Returns: A boolean value indicating whether the two instances have the same information.
    func hasSameInformation(_ infoIn: ResistivityMeasurementInfo) -> Bool {
        
        if self.shouldCalculateResistivity != infoIn.shouldCalculateResistivity { return false }
        
        if self.thickness != infoIn.thickness { return false}
        
        if self.thicknessCorrectionFactor != infoIn.thicknessCorrectionFactor { return false }
        
        if self.finiteWidthCorrectionFactor != infoIn.finiteWidthCorrectionFactor { return false }
        
        return true
    }
}


extension ResistivityMeasurementInfo {
    // MARK: - Convenience Properties for calculating the resistivity
    
    /// Convenience property to get the thickness value.
    private var t: Double { return thickness }
    /// Convenience property to get the thickness correction factor value.
    private var f1: Double { return thicknessCorrectionFactor }
    /// Convenience property to get the finite width correction factor value.
    private var f2: Double { return finiteWidthCorrectionFactor }
    
    /// Calculates the resistivity of the material based on the provided resistance.
    ///
    /// See: https://www.ossila.com/pages/sheet-resistance-theory for more information on how resistivity is calcluated
    /// - Parameter resistance: The electrical resistance of the material.
    /// - Returns: The calculated resistivity if `shouldCalculateResistivity` is true, otherwise returns NaN.
    func resistivity(forResistance resistance: Double) -> Double {
        
        // Source
        // https://www.ossila.com/pages/sheet-resistance-theory
        if shouldCalculateResistivity {
            return (Double.pi / log(2)) * t * f1 * f2 * resistance
        } else {
            return .nan
        }
    }
}

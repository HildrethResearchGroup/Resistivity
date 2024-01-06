//
//  LineResistanceInfo.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/11/23.
//

import Foundation

/// A structure to hold information related to the calculation of line resistance.
struct LineResistanceInfo {
    /// A boolean value indicating whether the line resistance should be calculated.
    var shouldCalculateLineResistance: Bool
    
    /// An optional double value representing the voltage sensing gap, which is used in the calculation of line resistance.
    var voltageSensingGap: Double?
    
    /// Calculates the line resistance based on a given resistance and the voltage sensing gap.
    ///
    /// - Parameter resistance: The resistance value from which to calculate the line resistance.
    /// - Returns: The calculated line resistance if possible, or NaN if the calculation should not be performed or if the voltage sensing gap is not set or zero.
    func lineResistance(forResistance resistance: Double) -> Double {
        
        // If the calculation of line resistance is disabled, return NaN.
        if shouldCalculateLineResistance == false {
            return .nan
        }
        
        // If the voltage sensing gap is not set, return NaN.
        guard let gap = voltageSensingGap else { return .nan }
        
        // If the voltage sensing gap is zero, return NaN to avoid division by zero.
        if gap == .zero { return .nan }
        
        // Calculate and return the line resistance by dividing the resistance by the voltage sensing gap.
        return resistance / gap
    }
}

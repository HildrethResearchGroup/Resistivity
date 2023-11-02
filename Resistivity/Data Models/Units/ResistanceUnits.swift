//
//  ResistanceUnits.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/29/23.
//

import Foundation

/// Used to set the units for resistance.  Base value is set to 1.0 Ohms (Ω).
///
/// The ResistanceUnits enum is used to scale the values of a measured resistance from the base units (Ohms) to a new unit.
///
/// Cases:
///   - nanoOhms: 1.0E-9 Ω
///   - microOhms: 1.0E-6 Ω
///   - milliOhms: 1.0E-3 Ω
///   - ohms: 1.0 Ω
///   - kiloOhms: 1.0E3 Ω
///   - megaOhms: 1.0E6 Ω
///   - gigOhms: 1.0E9 Ω
///
enum ResistanceUnits: ConvertableUnits {
    case nanoOhms
    case microOhms
    case milliOhms
    case ohms
    case kiloOhms
    case megaOhms
    case gigOhms
    
    
    
    /// Provides the scale factor to go from the base value to target Resistance Units
    /// - Parameter unitIn: Resistance Units to scale from the base units to
    /// - Returns: Scale factor to go from the unitsIn to the base units.
    func scaleFactor(for unitIn: ResistanceUnits) -> Double {
        switch unitIn {
        case .nanoOhms: return 1.0E-9
        case .microOhms: return 1.0E-6
        case .milliOhms: return 1.0E-3
        case .ohms: return 1.0
        case .kiloOhms: return 1.0E3
        case .megaOhms: return 1.0E6
        case .gigOhms: return 1.0E9
        }
    }
    
    
    
    /// Scales a value from set Resistance units to the base units
    /// - Parameter valueIn: Double value to scale
    /// - Returns: Scaled value
    func scaledFromBaseValue(_ valueIn: Double) -> Double {
        let scalefactor = scaleFactor(for: self)
        
        return valueIn * scalefactor
    }
    
    
    /// Scales a value from set Resistance units to Ohms
    /// - Parameter valueIn: Double value to scale
    /// - Returns: Scaled value
    func scaledFromBaseOhms(_ valueIn: Double) -> Double {
        return scaledFromBaseValue(valueIn)
    }
}






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
enum ResistanceUnits: String, Codable, CaseIterable, Identifiable {
    var id: Self {self}
    
    case nanoOhms
    case microOhms
    case milliOhms
    case ohms
    case kiloOhms
    case megaOhms
    case gigOhms
    
}


/// Extension to make `ResistanceUnits` conform to `ConvertableUnits` protocol.
extension ResistanceUnits: ConvertableUnits {
    /// Provides the scale factor to go from the base value to target Resistance Units
    /// - Parameter unitIn: Resistance Units to scale from the base units to
    /// - Returns: Scale factor to go from the unitsIn to the base units.
    func scaleFactor(for unitIn: ResistanceUnits) -> Double {
        switch unitIn {
        case .nanoOhms: return 1.0E9
        case .microOhms: return 1.0E6
        case .milliOhms: return 1.0E3
        case .ohms: return 1.0
        case .kiloOhms: return 1.0E-3
        case .megaOhms: return 1.0E-6
        case .gigOhms: return 1.0E-9
        }
    }
    
    
    /// Returns the scale factor for the current unit to convert to base units (Ohms).
    ///
    /// This method is a convenience wrapper around the `scaleFactor(for:)` method, using the current unit instance.
    ///
    /// - Returns: The scale factor to convert the current unit to Ohms.
    func scaleFactor() -> Double {
        scaleFactor(for: self)
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



extension ResistanceUnits: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .nanoOhms: return "nΩ"
            case .microOhms: return "µΩ"
            case .milliOhms: return "mΩ"
            case .ohms: return "Ω"
            case .kiloOhms: return "kΩ"
            case .megaOhms: return "MΩ"
            case .gigOhms: return "GΩ"
            }
        }
    }
}

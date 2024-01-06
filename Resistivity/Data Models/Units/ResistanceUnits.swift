//
//  ResistanceUnits.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/29/23.
//

import Foundation

/// An enumeration representing different units of electrical resistance.
///
/// This enumeration provides a set of resistance units ranging from nanoOhms to gigOhms,
/// each with an associated raw value that represents the unit's string representation.
/// It conforms to `Codable` for easy serialization, `CaseIterable` for iterating over all cases,
/// and `Identifiable` for use in SwiftUI or other frameworks that require unique identification of enum cases.
enum ResistanceUnits: String, Codable, CaseIterable, Identifiable {
    var id: Self { self }
    
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
    /// Provides the scale factor to convert a resistance value from the specified unit to Ohms.
    ///
    /// - Parameter unitIn: The unit from which to convert.
    /// - Returns: The scale factor to convert from the specified unit to Ohms.
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
    
    /// Returns the scale factor for the current unit to convert to Ohms.
    ///
    /// This method is a convenience wrapper around the `scaleFactor(for:)` method, using the current unit instance.
    ///
    /// - Returns: The scale factor to convert the current unit to Ohms.
    func scaleFactor() -> Double {
        scaleFactor(for: self)
    }
    
    /// Scales a resistance value from the base unit (Ohms) to the current unit.
    ///
    /// - Parameter valueIn: The resistance value in Ohms to be scaled.
    /// - Returns: The scaled resistance value in the current unit.
    func scaledFromBaseValue(_ valueIn: Double) -> Double {
        let scalefactor = scaleFactor(for: self)
        return valueIn * scalefactor
    }
    
    /// Scales a resistance value from Ohms to the current unit.
    ///
    /// This method is equivalent to `scaledFromBaseValue(_:)` and is provided for clarity when working specifically with Ohms.
    ///
    /// - Parameter valueIn: The resistance value in Ohms to be scaled.
    /// - Returns: The scaled resistance value in the current unit.
    func scaledFromBaseOhms(_ valueIn: Double) -> Double {
        return scaledFromBaseValue(valueIn)
    }
}

/// Extension to provide a textual representation of the `ResistanceUnits`.
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

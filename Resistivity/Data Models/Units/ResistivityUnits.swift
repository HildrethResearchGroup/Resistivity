//
//  ResistivityUnits.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/31/23.
//

import Foundation

/// An enumeration representing different units of resistivity.
///
/// Cases:
///   - microOhm_centimeters: 1.0E-8 Ω-m
///   - ohm_micrometers:  1.0E-6 Ω-m
///   - ohm_millimeters: 1.0E-3 Ω-m
///   - ohm_meters: 1.0 Ω-m
enum ResistivityUnits: String, Codable, CaseIterable, Identifiable {
    var id: Self {self}
    
    case microOhm_centimeters
    case ohm_micrometers
    case ohm_millimeters
    case ohm_meters
}



/// Extension to make `ResistivityUnits` conform to `ConvertableUnits` protocol.
extension ResistivityUnits: ConvertableUnits {
    
    /// Returns the scale factor to convert a resistivity value from the given unit to ohm meters.
    /// - Parameter unitIn: The unit from which the conversion will start.
    /// - Returns: The scale factor as a `Double`.
    func scaleFactor(for unitIn: ResistivityUnits) -> Double {
        switch unitIn {
        case .ohm_meters: return 1.0
        case .ohm_millimeters: return 1_000.0
        case .ohm_micrometers: return 1_000_000.0
        case .microOhm_centimeters: return 100.0 * 1E6
        }
    }
    
    /// Returns the scale factor to convert a resistivity value from the current unit to ohm meters.
    /// - Returns: The scale factor as a `Double`.
    func scaleFactor() -> Double {
        scaleFactor(for: self)
    }
    
    /// Converts a resistivity value from ohm meters to the current unit.
    /// - Parameter valueIn: The resistivity value in ohm meters to be converted.
    /// - Returns: The converted resistivity value in the current unit.
    func scaledFromBaseValue(_ valueIn: Double) -> Double {
        return valueIn * self.scaleFactor()
    }
    
    /// Converts a resistivity value from ohm meters to the current unit.
    /// This is a convenience method that calls `scaledFromBaseValue`.
    /// - Parameter valueIn: The resistivity value in ohm meters to be converted.
    /// - Returns: The converted resistivity value in the current unit.
    func scaledFromBaseOhm_meters(_ valueIn: Double) -> Double {
        return scaledFromBaseValue(valueIn)
    }
    
}



extension ResistivityUnits: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .microOhm_centimeters: return "µΩ-cm"
            case .ohm_micrometers: return "Ω-µm"
            case .ohm_millimeters: return "Ω-mm"
            case .ohm_meters: return "Ω-m"
            }
        }
    }
}

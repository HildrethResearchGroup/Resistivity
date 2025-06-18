//
//  ConvertableUnits_Protocol.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/29/23.
//

import Foundation


protocol ConvertableUnits: CustomStringConvertible {
    associatedtype Element: ConvertableUnits
    
    /// Provides the scale factor to go from the base value to target Units
    /// - Parameter unitIn: Resistance Units to scale from the base units to
    /// - Returns: Scale factor to go from the unitsIn to the base units.
    func scaleFactor(for: Element) -> Double
    
    /// Provides the scale factor to go from the base value to enum's units
    /// - Returns: Scale factor from base units
    func scaleFactor() -> Double
    
    /// Scales a value from set units to the base units
    /// - Parameter valueIn: Double value to scale
    /// - Returns: Scaled value in base units
    func scaledToBaseValue(_ valueIn: Double) -> Double
    
    
    /// Scales a value from the Base Units to the Target Units
    /// - Parameter valueIn: Double value to scale
    /// - Returns: Scaled value from base units to target units
    func scaledFromBaseValue(_ valueIn: Double) -> Double
}

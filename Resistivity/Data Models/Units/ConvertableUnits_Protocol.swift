//
//  ConvertableUnits_Protocol.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/29/23.
//

import Foundation


protocol ConvertableUnits {
    associatedtype Element: ConvertableUnits
    
    /// Provides the scale factor to go from the base value to target  Units
    /// - Parameter unitIn: Resistance Units to scale from the base units to
    /// - Returns: Scale factor to go from the unitsIn to the base units.
    func scaleFactor(for: Element) -> Double
    
    /// Scales a value from set units to the base units
    /// - Parameter valueIn: Double value to scale
    /// - Returns: Scaled value
    func scaledFromBaseValue(_ valueIn: Double) -> Double
}

//
//  TimeUnits.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/29/23.
//

import Foundation



enum TimeUnits: ConvertableUnits {
    case microseconds
    case milliseconds
    case seconds
    case minutes
    case hours
    
    
    /// Provides the scale factor to go from the base value to target Time Units
    /// - Parameter unitIn: Time Units to scale from the base units to
    /// - Returns: Scale factor to go from the unitsIn to the base units.
    func scaleFactor(for unitIn: TimeUnits) -> Double {
        switch unitIn {
        case .microseconds: return 1.0E-6
        case .milliseconds: return 1.0E-3
        case .seconds: return 1.0
        case .minutes: return (1.0/60.0)
        case .hours: return (1.0 / (60.0 * 60.0))
        }
    }
    
    
    /// Scales a value from set Resistance units to the base units
    /// - Parameter valueIn: Double value to scale
    /// - Returns: Scaled value
    func scaledFromBaseValue(_ valueIn: Double) -> Double {
        let scalefactor = scaleFactor(for: self)
        
        return valueIn * scalefactor
    }
    
    
    /// Scales a value from set Resistance units to the base units
    ///
    /// - Parameters:
    ///    - valueIn: Double value to scale
    ///
    /// - Returns: Scaled value
    func scaledFromBaseSeconds(_ valueIn: Double) -> Double {
        return scaledFromBaseValue(valueIn)
    }
}



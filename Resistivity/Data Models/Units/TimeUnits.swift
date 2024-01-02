//
//  TimeUnits.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/29/23.
//

import Foundation




/// An enumeration representing different time units that can be converted.
///
/// Seconds are the base unit.
/// This enum conforms to `ConvertableUnits` protocol and provides cases for common time units.
/// It can be used to convert between these units and perform calculations with time values.
///
/// Cases:
///   - microsecons: 1.0E-6 sec
///   - milliseconds: 1.0E-3 sec
///   - seconds: 1.0 sec
///   - minutes: 60 sec
///   - hours: 3,600 sec
///
enum TimeUnits: String, Codable {
    case microseconds
    case milliseconds
    case seconds
    case minutes
    case hours
}


/// Extension to make `TimeUnits` conform to `ConvertableUnits` protocol.
extension TimeUnits: ConvertableUnits {
    
    /// Provides the scale factor to go from the base value to target Time Units
    /// - Parameter unitIn: Time Units to scale from the base units to
    /// - Returns: Scale factor to go from the unitsIn to the base units.
    func scaleFactor(for unitIn: TimeUnits) -> Double {
        switch unitIn {
        case .microseconds: return 1.0E6
        case .milliseconds: return 1.0E3
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
    
    
    /// Returns the scale factor for the current time unit instance.
    ///
    /// This method is a convenience wrapper around the `scaleFactor(for:)` method that uses the current instance as the parameter.
    /// It's used to obtain the scale factor to convert a value from the base unit (seconds) to the unit represented by the instance.
    ///
    /// - Returns: A `Double` representing the scale factor for the current time unit.
    func scaleFactor() -> Double {
        return scaleFactor(for: self)
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


extension TimeUnits: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .microseconds: return "µs"
            case .milliseconds: return "ms"
            case .seconds: return "s"
            case .minutes: return "min"
            case .hours: return "hrs"
            }
        }
    }
}

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
///   - microseconds: Represents a microsecond, which is 1.0E-6 of a second.
///   - milliseconds: Represents a millisecond, which is 1.0E-3 of a second.
///   - seconds: Represents a second, the base unit of time in this context.
///   - minutes: Represents a minute, which is equivalent to 60 seconds.
///   - hours: Represents an hour, which is equivalent to 3,600 seconds.
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
    
    /// Provides the scale factor to convert from the base unit (seconds) to the specified time unit.
    ///
    /// - Parameter unitIn: The `TimeUnits` value to which the conversion scale factor is required.
    /// - Returns: The scale factor as a `Double` to convert from seconds to the specified unit.
    func scaleFactor(for unitIn: TimeUnits) -> Double {
        switch unitIn {
        case .microseconds: return 1.0E6
        case .milliseconds: return 1.0E3
        case .seconds: return 1.0
        case .minutes: return (1.0/60.0)
        case .hours: return (1.0 / (60.0 * 60.0))
        }
    }
    
    /// Scales a value from the base unit (seconds) to the unit represented by the instance.
    ///
    /// - Parameter valueIn: The value in seconds to be scaled.
    /// - Returns: The scaled value as a `Double` in the unit represented by the instance.
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
    
    /// Scales a value from the base unit (seconds) to the unit represented by the instance.
    ///
    /// This method is a convenience wrapper around the `scaledFromBaseValue(_:)` method that uses the current instance as the parameter.
    /// It's used to scale a value from seconds to the unit represented by the instance.
    ///
    /// - Parameter valueIn: The value in seconds to be scaled.
    /// - Returns: The scaled value as a `Double` in the unit represented by the instance.
    func scaledFromBaseSeconds(_ valueIn: Double) -> Double {
        return scaledFromBaseValue(valueIn)
    }
}

/// Extension to conform `TimeUnits` to `CustomStringConvertible` for better string representation.
extension TimeUnits: CustomStringConvertible {
    /// Provides a textual representation of the time unit.
    var description: String {
        switch self {
        case .microseconds: return "µs"
        case .milliseconds: return "ms"
        case .seconds: return "s"
        case .minutes: return "min"
        case .hours: return "hrs"
        }
    }
}

//
//  LocationInformation.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

/// `Location` represents a physical location where measurements are taken.
/// It holds information about the location and a collection of measurements.
class Location {
    // MARK: - Properties
    
    /// Unique identifier for the location.
    var id = UUID()
    
    /// Information about the location such as coordinates, name, etc.
    var info: LocationInfo

    /// A collection of measurements taken at this location.
    /// When a new measurement is added, a notification is posted.
    var measurements: [Measurement] = [] {
        didSet {
            NotificationCenter.default.post(name: .newMeasurementAdded, object: self)
        }
    }
    
    // MARK: - Initializers
    
    /// Initializes a new `Location` with the provided `LocationInfo`.
    /// - Parameter locationInfo: The information about the location.
    init(_ locationInfo: LocationInfo) {
        self.info = locationInfo
    }
}

// MARK: - Adding Measurements
extension Location {
    /// Adds a new measurement to the location.
    /// Increments the measurement number and appends a new `Measurement` object to the `measurements` array.
    /// - Parameters:
    ///   - resistanceIn: The resistance value of the measurement.
    ///   - sampleInfo: Information about the sample being measured.
    ///   - resistivityInfo: Information about the resistivity measurement.
    ///   - lineResistanceInfo: Information about the line resistance.
    ///   - globalMeasurementNumber: A global identifier for the measurement across all locations.

    func addMeasurement(withResistance resistanceIn: Double, sampleInfo: SampleInfo, resistivityInfo: ResistivityMeasurementInfo, lineResistanceInfo: LineResistanceInfo, globalMeasurementNumber: Int) {
        
        // Increment the measurement number to reflect a new measurement being added.
        info.measurementNumber += 1
        
        // Create a new Measurement instance using the provided resistance value, sample information,
        // location information, resistivity information, line resistance information, and a global measurement number.
        let newMeasurement = Measurement(resistance: resistanceIn,
                                         sampleInfo: sampleInfo,
                                         locationInfo: info,
                                         resistivityInfo: resistivityInfo,
                                         lineResistanceInfo: lineResistanceInfo,
                                         globalMeasurementNumber: globalMeasurementNumber)
        
        // Append the newly created Measurement instance to the measurements array.
        // This will trigger the didSet observer on the measurements property,
        // which posts a notification that a new measurement has been added.
        measurements.append(newMeasurement)
    }
}

// MARK: - Common Conformances
extension Location: Identifiable, Equatable {
    /// Determines if two `Location` instances are equal based on their identifiers.
    /// - Parameters:
    ///   - lhs: The left-hand side `Location` instance to compare.
    ///   - rhs: The right-hand side `Location` instance to compare.
    /// - Returns: A Boolean value indicating whether the two instances are equal.
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

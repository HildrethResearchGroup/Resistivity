//
//  Measurement.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation

/// A structure representing a single measurement in a resistivity experiment.
struct Measurement {
    /// A unique identifier for the measurement.
    var id = UUID()
    
    /// The resistance value obtained from the measurement.
    let resistance: Double
    
    /// Information about the sample being measured.
    var sampleInfo: SampleInfo
    
    /// Information about the location where the measurement is taken.
    var locationInfo: LocationInfo
    
    /// Information specific to the resistivity measurement.
    var resistivityInfo: ResistivityMeasurementInfo
    
    /// Information about the line resistance.
    var lineResistanceInfo: LineResistanceInfo
    
    /// A global number assigned to the measurement for identification.
    var globalMeasurementNumber: Int
    
    /// A number representing the measurement count for the sample.
    var sampleMeasurementNumber: Int {  sampleInfo.sampleNumber + sampleInfo.measurementNumber  }
    
    /// A number representing the measurement count for the location.
    var locationMeasurementNumber: Int {  locationInfo.locationNumber + locationInfo.measurementNumber  }
    
    /// A string identifier combining sample and location information.
    var sampleID: String {  return "\(sampleInfo.sampleNumber)-\(locationInfo.locationNumber)-\(locationInfo.measurementNumber)"  }
    
    /// The date and time when the measurement was taken.
    let date: Date = .now
    /// The duration of the measurement.
    let measurementDuration: Duration = .zero
    
    /// The calculated resistivity value, initialized to zero.  
    ///
    /// Returns `.nan` if `shouldCalculateResistivity` is set to false
    var resistivity: Double { resistivityInfo.resistivity(forResistance: resistance) }
    
    
    var lineResistance: Double { lineResistanceInfo.lineResistance(forResistance: resistance) }
    
}

// MARK: - Common Conformances

extension Measurement: Identifiable, Hashable, Comparable {
    /// Compares two `Measurement` instances based on their resistance values.
    /// - Parameters:
    ///   - lhs: The left-hand side `Measurement` instance to compare.
    ///   - rhs: The right-hand side `Measurement` instance to compare.
    /// - Returns: A Boolean value indicating whether the left-hand side instance is less than the right-hand side instance.
    static func < (lhs: Measurement, rhs: Measurement) -> Bool {
        lhs.resistance < rhs.resistance
    }
    
    /// Checks if two `Measurement` instances are equal based on their unique identifiers.
    /// - Parameters:
    ///   - lhs: The left-hand side `Measurement` instance to compare.
    ///   - rhs: The right-hand side `Measurement` instance to compare.
    /// - Returns: A Boolean value indicating whether the two instances are equal.
    static func == (lhs: Measurement, rhs: Measurement) -> Bool {
        lhs.id == rhs.id
    }
    
    /// Hashes the essential components of the `Measurement` by feeding them into the given hasher.
    /// - Parameter hasher: The hasher to use when combining the components of the `Measurement`.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


// MARK: - Calculate Resistivity
extension Measurement {
    /// Calculates the resistivity based on the measurement information.
    /// - Returns: The calculated resistivity as a `Double`.
    func calculateResistivity() -> Double {
        // TODO: Setup Resistivity Calculation
        return 0.0
    }
}


// MARK: - Filterin
extension Measurement {
    /// Checks if the measurement contains the given information string in any of its properties.
    /// 
    /// This is used as part of the filtering process when using the applications search feature.
    /// - Parameter infoString: The string to search for within the measurement's properties.
    /// - Returns: A Boolean value indicating whether the measurement contains the information string.
    func contains(information infoString: String) -> Bool {
        
        if infoString.isEmpty { return true }
         
        if self.sampleInfo.name.localizedCaseInsensitiveContains(infoString) { return true }
        
        if self.locationInfo.name.localizedCaseInsensitiveContains(infoString) { return true }
        
        if self.sampleID.localizedCaseInsensitiveContains(infoString) { return true }
        
        return false
    }
}


// MARK: - Units Scaling
extension Measurement {
    func scaledResistance(_ units: ResistanceUnits) -> Double {
        return units.scaledFromBaseOhms(resistance)
    }
    
    func scaledResistivity(_ units: ResistivityUnits) -> Double {
        return units.scaledFromBaseOhm_meters(resistance)
    }
}

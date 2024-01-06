//
//  SampleInformation.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

/// `SampleInfo` is a structure that holds information about a sample in a resistivity measurement context.
/// It includes a unique identifier, a name, and numbers to track measurements and the sample itself.
struct SampleInfo {
    /// A unique identifier for the sample, automatically generated upon creation.
    var id = UUID()
    /// The name of the sample.
    var name: String
    
    /// The number of measurements taken for this sample.
    var measurementNumber = 0
    
    /// An identifier for the sample number, used for sorting and comparison.
    var sampleNumber = 0
}

/// Extension to make `SampleInfo` conform to `Identifiable`, `Equatable`, and `Comparable` protocols.
/// This allows `SampleInfo` to be used with SwiftUI lists, compared, and sorted.
extension SampleInfo: Identifiable, Equatable, Comparable {
    /// Compares two `SampleInfo` instances based on their `sampleNumber`.
    /// - Parameters:
    ///   - lhs: The left-hand side `SampleInfo` instance to compare.
    ///   - rhs: The right-hand side `SampleInfo` instance to compare.
    /// - Returns: A Boolean value indicating whether the left-hand side instance is less than the right-hand side instance.
    static func < (lhs: SampleInfo, rhs: SampleInfo) -> Bool {
        lhs.sampleNumber < rhs.sampleNumber
    }
    
    /// Checks if two `SampleInfo` instances are equal based on their unique identifiers.
    /// - Parameters:
    ///   - lhs: The left-hand side `SampleInfo` instance to compare.
    ///   - rhs: The right-hand side `SampleInfo` instance to compare.
    /// - Returns: A Boolean value indicating whether the two instances have the same identifier.
    static func == (lhs: SampleInfo, rhs: SampleInfo) -> Bool {
        lhs.id == rhs.id
    }
}

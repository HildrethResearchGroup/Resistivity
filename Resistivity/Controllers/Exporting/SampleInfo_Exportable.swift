//
//  SampleInfo_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

/// Extension of `SampleInfo` to conform to the `Exportable` protocol.
/// This allows instances of `SampleInfo` to be exported with a standardized header and data representation.
extension SampleInfo: Exportable {
    
    /// Creates a header for exporting `SampleInfo` data.
    /// - Returns: An array of strings representing the column headers for the associated data.
    func header() -> [String] {
        return ["Sample Name",
                "Sample Number",
                "Sample Measurement Number"]
    }
    
    /// Creates an array of strings representing the data of the `SampleInfo`.
    /// - Returns: An array of strings containing the sample's name, sample number, and measurement number.
    func data() -> [String] {
        return [name,
                String(sampleNumber),
                String(measurementNumber) ]
    }
}

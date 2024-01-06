//
//  LocationInfo_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

/// Extension of the `LocationInfo` struct that conforms to the `Exportable` protocol.
/// This allows instances of `LocationInfo` to be exported with a standardized header and data format.
extension LocationInfo: Exportable {
    
    /// Generates a header for a CSV or similar export format.
    /// - Returns: An array of strings representing the column headers for the associated data.
    func header() -> [String] {
        return ["Location Name",
                "Location Number",
                "Location Measurement Number"]
    }
    
    /// Generates the data representation of the `LocationInfo` instance for export.
    /// - Returns: An array of strings representing the values of the instance's properties.
    func data() -> [String] {
        return [name,
                String(locationNumber),
                String(measurementNumber) ]
    }
}

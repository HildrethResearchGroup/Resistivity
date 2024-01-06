//  Measurement_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

/// Extension of the `Measurement` class that conforms to the `Exportable` protocol.
/// This extension provides functionality to export measurement data in a structured format.
extension Measurement: Exportable {
    
    /// Generates the header row for a CSV or similar export file.
    /// This method combines headers from the measurement itself and its related information.
    ///
    /// - Returns: An array of strings representing the column headers for the exported data.
    func header() -> [String] {
        // Basic measurement headers
        let section1 = ["Measurement Number",
                        "Sample ID",
                        "Resistance [Ω]",
                        "Resistivity [Ω-m]",
                        "Line Resistance [Ω/m]"
        ]
        
        // Headers from the sample information
        let section2 = self.sampleInfo.header()
        // Headers from the location information
        let section3 = self.locationInfo.header()
        // Headers from the line resistance information
        let section4 = self.lineResistanceInfo.header()
        // Headers from the resistivity information
        let section5 = self.resistivityInfo.header()
        
        // Additional headers for global context and timestamps
        let section6 = ["Global Measurement #",
                        "Sample Measurement #",
                        "Location Measurement #",
                        "Data Collected",
                        "Time Collected"]
        
        // Combine all headers into a single array
        var allHeadings = section1
        allHeadings.append(contentsOf: section2)
        allHeadings.append(contentsOf: section3)
        allHeadings.append(contentsOf: section4)
        allHeadings.append(contentsOf: section5)
        allHeadings.append(contentsOf: section6)
        
        return allHeadings
    }
    
    /// Generates the data row for a CSV or similar export file.
    /// This method combines data from the measurement itself and its related information.
    ///
    /// - Returns: An array of strings representing the data values for the exported data.
    func data() -> [String] {
        // Basic measurement data
        let section1 = [String(globalMeasurementNumber),
                        sampleID,
                        String(resistance),
                        String(resistivity),
                        String(lineResistance)]
        
        // Data from the sample information
        let section2 = self.sampleInfo.data()
        // Data from the location information
        let section3 = self.locationInfo.data()
        // Data from the line resistance information
        let section4 = self.lineResistanceInfo.data()
        // Data from the resistivity information
        let section5 = self.resistivityInfo.data()
        
        // Additional data for global context and timestamps
        let section6 = [String(globalMeasurementNumber),
                        String(sampleMeasurementNumber),
                        String(locationMeasurementNumber),
                        date.formatted(date: .complete, time: .omitted),
                        date.formatted(date: .omitted, time: .complete)]
        
        // Combine all data into a single array
        var allHeadings = section1
        allHeadings.append(contentsOf: section2)
        allHeadings.append(contentsOf: section3)
        allHeadings.append(contentsOf: section4)
        allHeadings.append(contentsOf: section5)
        allHeadings.append(contentsOf: section6)
        
        return allHeadings
    }
}

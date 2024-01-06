//
//  Sample_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/3/24.
//

import Foundation

/// Extension of the `Sample` class to conform to the `Exportable` protocol.
/// This allows instances of `Sample` to provide a standardized way of exporting their data.
extension Sample: Exportable {
    
    /// Generates a header for the sample data export.
    /// This header includes information from the sample itself, as well as its associated statistics.
    ///
    /// - Returns: An array of strings representing the column headers for the sample data.
    func header() -> [String] {
        // Get headers from the sample information and statistics.
        let sampleInfoHeader = self.info.header()
        let resistanceHeader = self.resistanceStatistics.header()
        let resistivityHeader = self.resistivityStatistics.header()
        let lineResistanceHeader = self.lineResistanceStatistics.header()
        
        // Combine all headers into a single array.
        let localHeader = sampleInfoHeader + resistanceHeader + resistivityHeader + lineResistanceHeader
        
        return localHeader
    }
    
    /// Generates the data for the sample export.
    /// This data includes information from the sample itself, as well as its associated statistics.
    ///
    /// - Returns: An array of strings representing the data values for the sample.
    func data() -> [String] {
        // Get data from the sample information and statistics.
        let sampleInfoData = self.info.data()
        let resistanceData = self.resistanceStatistics.data()
        let resistivityData = self.resistivityStatistics.data()
        let lineResistanceData = self.lineResistanceStatistics.data()
        
        // Combine all data into a single array.
        let localData = sampleInfoData + resistanceData + resistivityData + lineResistanceData
        
        return localData
    }
}

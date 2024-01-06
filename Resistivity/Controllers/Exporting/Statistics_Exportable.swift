//
//  Statistics_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

/// Extension of the `Statistics` class that conforms to the `Exportable` protocol.
/// This extension provides functionality to export statistical data in a textual format.
extension Statistics: Exportable {
    
    /// Creates a header for the statistical data export.
    /// - Returns: An array of strings representing the headers for mean, standard deviation, minimum, and maximum values, including units.
    func header() -> [String] {
        let unitsString = name + " [" + units + "]"
        let meanString = "Mean: " + unitsString
        let stdDevString = "Std. Dev. "  + unitsString
        let minString = "Min. " + unitsString
        let maxString = "Mix. " + unitsString
        
        return [meanString, stdDevString, minString, maxString]
    }
    
    /// Creates an array of statistical data as strings.
    /// - Returns: An array of strings representing the mean, standard deviation, minimum, and maximum values.
    func data() -> [String] {
        return [String(mean), String(standardDeviation), String(min), String(max)]
    }
    
    /// Generates a string that represents the file header for exporting the statistical data.
    /// - Returns: A string that contains the statistical data separated by newlines, ready to be used as a file header.
    func exportFileHeader() -> String {
        let exports = data()
        
        var exportString = ""
        
        // Iterates through the exported data, appending each piece of data followed by a newline character.
        for nextExport in exports {
            exportString.append(nextExport)
            exportString.append("\n")
        }
        
        // Removes the last newline character to avoid an extra line at the end of the header.
        exportString.removeLast()
        
        return exportString
    }
}

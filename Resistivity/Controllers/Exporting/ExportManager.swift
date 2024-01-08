//
//  ExportManager.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

/// `ExportManager` is responsible for exporting data to a file in CSV format.
/// It can handle exporting both individual measurements and sample statistics.
struct ExportManager {
    
    /// Exports an array of `Measurement` objects to a specified URL in CSV format.
    /// - Parameters:
    ///   - measurements: An array of `Measurement` objects to be exported.
    ///   - targetURL: The file URL where the CSV data will be written.
    /// - Throws: An error if the data could not be written to the file.
    func export(_ measurements: [Measurement], to targetURL: URL) throws {
        let exportStrings = self.collateMeasurements(measurements)
        
        let combinedData = combineLines(for: exportStrings)
        
        try combinedData.write(to: targetURL, atomically: true, encoding: .utf16)
    }
    
    /// Exports an array of `Sample` objects to a specified URL in CSV format.
    /// - Parameters:
    ///   - samples: An array of `Sample` objects to be exported.
    ///   - targetURL: The file URL where the CSV data will be written.
    /// - Throws: An error if the data could not be written to the file.
    func export(_ samples: [Sample], to targetURL: URL) throws {
        let exportStrings = self.collateSampleStatistics(samples)
        
        let combinedData = combineLines(for: exportStrings)
        
        try combinedData.write(to: targetURL, atomically: true, encoding: .utf16)
    }
    
    /// Exports both measurements and sample statistics to a single CSV file.
    /// The file will contain two sections: one for summary data and one for raw data.
    /// - Parameters:
    ///   - measurements: An array of `Measurement` objects to be included in the raw data section.
    ///   - samples: An array of `Sample` objects to be included in the summary data section.
    ///   - targetURL: The file URL where the combined CSV data will be written.
    /// - Throws: An error if the data could not be written to the file.
    func exportCombinedFile(measurements: [Measurement], samples: [Sample], to targetURL: URL) throws {
        
        // Get arrays of csv data lines
        let summaryStrings = self.collateSampleStatistics(samples)
        let measurementStrings = self.collateMeasurements(measurements)
        
        // Convert csv data lines to individual CSV strings
        let summaryCSV = combineLines(for: summaryStrings)
        let dataCSV = combineLines(for: measurementStrings)
        
        
        let combinedCSV = "Summary Data\n\n" + summaryCSV + "\n\n\n\nRaw Data\n\n" + dataCSV
        
        try combinedCSV.write(to: targetURL, atomically: true, encoding: .utf16)
        
    }
    
    /// Generates a CSV string from an array of `Measurement` objects.
    /// - Parameter measurements: An array of `Measurement` objects to be converted to a CSV string.
    /// - Returns: A CSV formatted string representing the measurements.
    func csv(for measurements: [Measurement]) -> String {
        let measurementStrings = collateMeasurements(measurements)
        
        let cvsOutput = self.csvString(for: measurementStrings)
        
        return cvsOutput
    }
}


// MARK: - Generate File Names
extension ExportManager {
    /// Generates a standard file name for raw data exports.
    /// - Returns: A string representing the file name for raw data.
    static func fileNameForRawData() -> String {
        return "Raw Data"
    }
    
    /// Generates a standard file name for summary data exports.
    /// - Returns: A string representing the file name for summary data.
    static func fileNameForSummaryData() -> String {
        return "Samples Summaries"
    }
}

// MARK: - Raw Data to CVS
extension ExportManager {
    /// Collates an array of `Measurement` objects into an array of CSV-compatible strings.
    /// - Parameter measurements: An array of `Measurement` objects to be collated.
    /// - Returns: An array of strings where each string is a CSV-formatted line.
    private func collateMeasurements(_ measurements: [Measurement]) -> [String] {
                
        var dataStrings:[String] = []
        
        guard let header = measurements.first?.header() else { return dataStrings }
        
        dataStrings.append(csvString(for: header))
        
        for nextMeasurement in measurements {
            let measurementData = nextMeasurement.data()
            
            let csvStrings = "\n" + csvString(for: measurementData)
            
            dataStrings.append(csvStrings)
        }
        
        return dataStrings
    }
    
    /// Converts an array of strings into a single CSV-formatted string.
    /// - Parameter strings: An array of strings to be converted.
    /// - Returns: A CSV-formatted string where each element is separated by a comma.
    private func csvString(for strings: [String]) -> String {
        var newString = ""
        
        for nextString in strings {
            newString += nextString + ", "
        }
        
        newString.removeLast(2)
        
        return newString
    }
    
    /// Combines an array of strings into a single string with each element on a new line.
    /// - Parameter stringLines: An array of strings to be combined.
    /// - Returns: A string where each element of the array is separated by a newline character.
    private func combineLines(for stringLines: [String]) -> String {
        var newString = ""
        
        for nextline in stringLines {
            newString += "\n" + nextline
        }
        
        return newString
    }
}


// MARK: - Statistics to CVS
extension ExportManager {
    /// Collates an array of `Sample` objects into an array of CSV-compatible strings.
    /// - Parameter samples: An array of `Sample` objects to be collated.
    /// - Returns: An array of strings where each string is a CSV-formatted line.
    private func collateSampleStatistics(_ samples: [Sample]) -> [String] {
        var dataStrings: [String] = []
        
        guard let headerSample = samples.first else { return dataStrings }
        
        let header = headerSample.header()
        
        dataStrings.append(csvString(for: header))
        
        for nextSample in samples {
            let sampleData = nextSample.data()
            
            dataStrings.append(csvString(for: sampleData))
        }
        
        return dataStrings
    }
}

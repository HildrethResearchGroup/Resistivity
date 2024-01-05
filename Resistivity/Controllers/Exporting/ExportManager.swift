//
//  ExportManager.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

struct ExportManager {
    func export(_ measurements: [Measurement], to targetURL: URL) throws {
        let exportStrings = self.collateMeasurements(measurements)
        
        let combinedData = combineLines(for: exportStrings)
        
        try combinedData.write(to: targetURL, atomically: true, encoding: .utf8)
    }
    
    func export(_ samples: [Sample], to targetURL: URL) throws {
        let exportStrings = self.collateSampleStatistics(samples)
        
        let combinedData = combineLines(for: exportStrings)
        
        try combinedData.write(to: targetURL, atomically: true, encoding: .utf8)
    }
    
    func exportCombinedFile(measurements: [Measurement], samples: [Sample], to targetURL: URL) throws {
        
        // Get arrays of csv data lines
        let summaryStrings = self.collateSampleStatistics(samples)
        let measurementStrings = self.collateMeasurements(measurements)
        
        // Convert csv data lines to individual CSV strings
        let summaryCSV = combineLines(for: summaryStrings)
        let dataCSV = combineLines(for: measurementStrings)
        
        
        let combinedCSV = "Summary Data\n\n" + summaryCSV + "\n\n\n\nRaw Data\n\n" + dataCSV
        
        try combinedCSV.write(to: targetURL, atomically: true, encoding: .utf8)
        
    }
    
    func csv(for measurements: [Measurement]) -> String {
        let measurementStrings = collateMeasurements(measurements)
        
        let cvsOutput = self.csvString(for: measurementStrings)
        
        return cvsOutput
    }
}


// MARK: - Generate File Names
extension ExportManager {
    static func fileNameForRawData() -> String {
        return "Raw Data"
    }
    
    static func fileNameForSummaryData() -> String {
        return "Samples Summaries"
    }
}

// MARK: - Raw Data to CVS
extension ExportManager {
    private func collateMeasurements(_ measurements: [Measurement]) -> [String] {
                
        var dataStrings:[String] = []
        
        guard let header = measurements.first?.header() else { return dataStrings }
        
        dataStrings.append(csvString(for: header))
        
        for nextMeasurement in measurements {
            let measurementData = nextMeasurement.data()
            
            dataStrings.append(csvString(for: measurementData))
        }
        
        return dataStrings
    }
    
    private func csvString(for strings: [String]) -> String {
        var newString = ""
        
        for nextString in strings {
            newString += nextString + ", "
        }
        
        newString.removeLast()
        
        return newString
    }
    
    private func combineLines(for stringLines: [String]) -> String {
        var newString = ""
        
        for nextline in stringLines {
            newString += nextline + "\n"
        }
        
        return newString
    }
}


// MARK: - Statistics to CVS
extension ExportManager {
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

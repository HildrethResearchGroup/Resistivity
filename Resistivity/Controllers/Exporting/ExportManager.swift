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

// MARK: - Data to CVS
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


// MARK: - Headers
extension ExportManager {
    func generateHeader(equipmentInfo: String, forSamples samples: [Sample]) -> String {
        var headerString = ""
        headerString.append(equipmentInfo + "\n")
        
        
        let date = samples.first?.flattendMeasurements.first?.date ?? .now
        let dateString = "Date Measured: " + date.formatted(.dateTime) + "\n"
        headerString.append(dateString)
        
        let numberOfSamples = samples.count
        headerString.append("Samples: \(numberOfSamples)")
        
        var allMeasurements: [Measurement] = []
        for nextSample in samples {
            let nextMeasurements = nextSample.flattendMeasurements
            allMeasurements.append(contentsOf: nextMeasurements)
        }
        headerString.append("Total # of Measurements: \(allMeasurements.count)\n")
        
        var resistanceStatistics = Statistics<Measurement>(keyPath: \.resistance, name: "Resistance", units: "Ω")
        
        headerString.append(resistanceStatistics.exportFileHeader())
        
        return headerString
    }
}

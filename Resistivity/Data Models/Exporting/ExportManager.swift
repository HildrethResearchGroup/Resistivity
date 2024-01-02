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
    
    func csvString(for strings: [String]) -> String {
        var newString = ""
        
        for nextString in strings {
            newString += nextString + ", "
        }
        
        newString.removeLast()
        
        return newString
    }
    
    func combineLines(for stringLines: [String]) -> String {
        var newString = ""
        
        for nextline in stringLines {
            newString += nextline + "\n"
        }
        
        return newString
    }
}

//
//  Statistics_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

extension Statistics: Exportable {
    func header() -> [String] {
        let unitsString = name + " [" + units + "]"
        let meanString = "Mean: " + unitsString
        let stdDevString = "Std. Dev. "  + unitsString
        let minString = "Min. " + unitsString
        let maxString = "Mix. " + unitsString
        
        return [meanString, stdDevString, minString, maxString]
    }
    
    func data() -> [String] {
        return [String(mean), String(standardDeviation), String(min), String(max)]
    }
    
    
    func exportFileHeader() -> String {
        let exports = data()
        
        var exportString = ""
        
        for nextExport in exports {
            
            
            exportString.append(nextExport)
            exportString.append("\n")
        }
        
        exportString.removeLast()
        
        return exportString
    }
}

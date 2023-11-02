//
//  Statistics_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

extension Statistics: Exportable {
    func header() -> [String] {
        let meanString = "Mean: " + name + " [" + units + "]"
        let stdDevString = "Std. Dev. " + name + " [" + units + "]"
        
        return [meanString, stdDevString]
    }
    
    func data() -> [String] {
        return [String(mean), String(standardDeviation)]
    }
    
    
}

//
//  Sample_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/3/24.
//

import Foundation

extension Sample: Exportable {
    func header() -> [String] {
        let sampleInfoHeader = self.info.header()
        
        let resistanceHeader = self.resistanceStatistics.header()
        let resistivityHeader = self.resistivityStatistics.header()
        let lineResistanceHeader = self.lineResistanceStatistics.header()
        
        let localHeader = sampleInfoHeader + resistanceHeader + resistivityHeader + lineResistanceHeader
        
        return localHeader
    }
    
    func data() -> [String] {
        let sampleInfoData = self.info.data()
        
        let resistanceData = self.resistanceStatistics.data()
        let resistivityData = self.resistivityStatistics.data()
        let lineResistanceData = self.lineResistanceStatistics.data()
        
        let localData = sampleInfoData + resistanceData + resistivityData + lineResistanceData
        
        return localData
    }
    
    
}

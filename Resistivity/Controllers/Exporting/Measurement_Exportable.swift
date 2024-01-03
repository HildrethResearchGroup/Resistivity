//
//  Measurement_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

extension Measurement: Exportable {
    func header() -> [String] {
        let section1 = ["Measurement Number",
                        "Sample ID",
                        "Resistance [Ω]",
                        "Resistivity [Ω-m]",
                        "Line Resistance [Ω/m]"
        ]
        
        let section2 = self.sampleInfo.header()
        let section3 = self.locationInfo.header()
        let section4 = self.lineResistanceInfo.header()
        let section5 = self.resistivityInfo.header()
        
        let section6 = ["Global Measurement #",
                        "Sample Measurement #",
                        "Location Measurement #",
                        "Data Collected",
                        "Time Collected"]
        
        var allHeadings = section1
        allHeadings.append(contentsOf: section2)
        allHeadings.append(contentsOf: section3)
        allHeadings.append(contentsOf: section4)
        allHeadings.append(contentsOf: section5)
        allHeadings.append(contentsOf: section6)
        
        return allHeadings
    }
    
    func data() -> [String] {
        let section1 = [String(globalMeasurementNumber),
                        sampleID,
                        String(resistance),
                        String(resistivity),
                        String(lineResistance)]
        
        let section2 = self.sampleInfo.data()
        let section3 = self.locationInfo.data()
        let section4 = self.lineResistanceInfo.data()
        let section5 = self.resistivityInfo.data()
        
        let section6 = [String(globalMeasurementNumber),
                        String(sampleMeasurementNumber),
                        String(locationMeasurementNumber),
                        date.formatted(date: .complete, time: .omitted),
                        date.formatted(date: .omitted, time: .complete)]
        
        var allHeadings = section1
        allHeadings.append(contentsOf: section2)
        allHeadings.append(contentsOf: section3)
        allHeadings.append(contentsOf: section4)
        allHeadings.append(contentsOf: section5)
        allHeadings.append(contentsOf: section6)
        
        return allHeadings
    }
    
}

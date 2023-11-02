//
//  Measurement_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

extension Measurement: Exportable {
    func header() -> [String] {
        return ["Sample Name",
                "Sample Location",
                "Collected Date",
                "Collected Time",
                "Measurement Duration [sec]",
                "Resistance [Ω]",
                "Resistivity [Ω-m]"
        ]
    }
    
    func data() -> [String] {
        return [sampleInfo.name,
                location.name,
                date.formatted(date: .complete, time: .omitted),
                date.formatted(date: .omitted, time: .complete),
                measurementDuration.formatted(),
                String(resistance),
                String(resistivity),
                
        ]
    }
    
}

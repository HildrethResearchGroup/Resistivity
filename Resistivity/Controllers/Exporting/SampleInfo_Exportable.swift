//
//  SampleInfo_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

extension SampleInfo: Exportable {
    func header() -> [String] {
        return ["Sample Name",
                "Sample Number",
                "Sample Measurement Number"]
    }
    
    func data() -> [String] {
        return [name,
                String(sampleNumber),
                String(measurementNumber) ]
    }
}

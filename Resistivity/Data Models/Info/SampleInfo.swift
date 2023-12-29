//
//  SampleInformation.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

struct SampleInfo {
    var id = UUID()
    var name: String
    
    var measurementNumber = 0
    
    var sampleNumber = 0
}


extension SampleInfo: Identifiable, Equatable, Comparable {
    static func < (lhs: SampleInfo, rhs: SampleInfo) -> Bool {
        lhs.sampleNumber < rhs.sampleNumber
    }
    
    static func == (lhs: SampleInfo, rhs: SampleInfo) -> Bool {
        lhs.id == rhs.id
    }
}

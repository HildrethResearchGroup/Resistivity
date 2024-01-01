//
//  LineResistanceInfo.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/11/23.
//

import Foundation

struct LineResistanceInfo {
    var shouldCalculateLineResistance: Bool
    
    var voltageSensingGap: Double?
    
    func calculateLineResistance(_ resistance: Double) -> Double? {
        guard let gap = voltageSensingGap else {return nil}
        
        if gap == .zero {return .nan}
        
        return resistance / gap
    }
}



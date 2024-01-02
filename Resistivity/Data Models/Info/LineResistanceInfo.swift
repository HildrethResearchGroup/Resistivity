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
    
    func lineResistance(forResistance resistance: Double) -> Double {
        
        if shouldCalculateLineResistance == false {
            return .nan
        }
        
        guard let gap = voltageSensingGap else {return .nan}
        
        if gap == .zero {return .nan}
        
        return resistance / gap
    }
}



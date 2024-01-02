//
//  LineResistanceInfo_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

extension LineResistanceInfo: Exportable {
    func header() -> [String] {
        return ["Should Calculate Line Resistance",
                "Voltage Sensing Gap"]
    }
    
    func data() -> [String] {
        return [String(shouldCalculateLineResistance),
                String(voltageSensingGap ?? .nan)]
    }
}

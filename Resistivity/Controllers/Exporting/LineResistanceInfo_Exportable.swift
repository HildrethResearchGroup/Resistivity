//
//  LineResistanceInfo_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

/// Extension of `LineResistanceInfo` to conform to the `Exportable` protocol.
/// This allows instances of `LineResistanceInfo` to be exported in a structured format.
extension LineResistanceInfo: Exportable {
    
    /// Creates the header row for exporting `LineResistanceInfo`.
    /// - Returns: An array of strings representing the column headers for the data to be exported.
    func header() -> [String] {
        return ["Should Calculate Line Resistance",
                "Voltage Sensing Gap"]
    }
    
    /// Creates the data row for exporting `LineResistanceInfo`.
    /// - Returns: An array of strings representing the values of the properties to be exported.
    ///            If `voltageSensingGap` is nil, `.nan` is used to represent a non-applicable value.
    func data() -> [String] {
        return [String(shouldCalculateLineResistance),
                String(voltageSensingGap ?? .nan)]
    }
}

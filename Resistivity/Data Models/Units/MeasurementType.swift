//
//  MeasurementType.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/12/24.
//

import Foundation

enum MeasurementType: Int, CaseIterable, Identifiable, Codable {
    var id: Self { self }
    case resistance
    case resistivity
    case lineResistance
}

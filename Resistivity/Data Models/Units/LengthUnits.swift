//
//  LengthUnits.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/13/24.
//

import Foundation

enum LengthUnits: String, CaseIterable, Identifiable, Codable {
    var id: Self { self }
    
    case meter
    case centimeter
    case millimeter
    case micron
    case nanometer
}


extension LengthUnits: ConvertableUnits {
    func scaleFactor(for unitIn: LengthUnits) -> Double {
        switch unitIn {
        case .meter: return 1.0
        case .centimeter: return 1.0E2
        case .millimeter: return 1.0E3
        case .micron: return 1.0E6
        case .nanometer: return 1.0E9
        }
    }
    
    func scaleFactor() -> Double {
        scaleFactor(for: self)
    }
    
    func scaledFromBaseValue(_ valueIn: Double) -> Double {
        return valueIn * self.scaleFactor()
    }
    
    func scaledFromBaseMeters(_ valueIn: Double) -> Double {
        return scaledFromBaseValue(valueIn)
    }
}


extension LengthUnits: CustomStringConvertible {
    var description: String {
        switch self {
        case .meter: return "m"
        case .centimeter: return "cm"
        case .millimeter: return "mm"
        case .micron: return "µm"
        case .nanometer: return "nm"
        }
    }
}

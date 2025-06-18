//
//  LineResistanceUnits.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/8/24.
//

import Foundation


enum LineResistanceUnits: String, Codable, CaseIterable, Identifiable {
    var id: Self { self }
    
    case nanoOhmPerMeters
    case microOhmPerMeters
    case milliOhmPerMeters
    case ohmPerMeters
    case ohmPerMillimeter
    case kiloOhmPerMeters
    case megaOhmPerMeters
    case gigOhmPerMeters
}

extension LineResistanceUnits: ConvertableUnits {
    func scaleFactor() -> Double {
        scaleFactor(for: self)
    }
    
    func scaleFactor(for unitIn: LineResistanceUnits) -> Double {
        switch unitIn {
        case .nanoOhmPerMeters: return 1.0E9
        case .microOhmPerMeters: return 1.0E6
        case .milliOhmPerMeters: return 1.0E3
        case .ohmPerMeters: return 1.0
        case .kiloOhmPerMeters: return 1.0E-3
        case .megaOhmPerMeters: return 1.0E-6
        case .gigOhmPerMeters: return 1.0E-9
        case .ohmPerMillimeter: return 1.0E-3
        }
    }
    
    
    func scaledToBaseValue(_ valueIn: Double) -> Double {
        let scalefactor = scaleFactor(for: self)
        
        // TODO: Check Change
        // return valueIn * scalefactor
        return valueIn / scalefactor
    }
    
    
    func scaledFromBaseValue(_ valueIn: Double) -> Double {
        let scalefactor = scaleFactor(for: self)
        
        return valueIn * scalefactor
    }
}


/// Extension to provide a textual representation of the `ResistanceUnits`.
extension LineResistanceUnits: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .nanoOhmPerMeters: return "nΩ/m"
            case .microOhmPerMeters: return "µΩ/m"
            case .milliOhmPerMeters: return "mΩ/m"
            case .ohmPerMeters: return "Ω/m"
            case .kiloOhmPerMeters: return "kΩ/m"
            case .megaOhmPerMeters: return "MΩ/m"
            case .gigOhmPerMeters: return "GΩ/m"
            case .ohmPerMillimeter: return "Ω/mm"
            }
        }
    }
}

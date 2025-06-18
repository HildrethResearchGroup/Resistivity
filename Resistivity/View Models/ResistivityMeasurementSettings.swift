//
//  MeasurementSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

/// `ResistivityMeasurementSettings` manages the user's preferences for calculating resistivity.
/// It persists settings to `UserDefaults` to maintain consistency between app launches.
class ResistivityMeasurementSettings: ObservableObject {
    /// Unique identifier for the settings object.
    var id = UUID()
    
    /// Determines whether resistivity should be calculated.
    /// When set, the value is stored to `UserDefaults`.
    @Published var shouldCalculateResistivity: Bool {
        didSet { UserDefaults.standard.set(shouldCalculateResistivity, forKey: "shouldCalculateResistivity") }
    }
    
    /// The thickness of the material for which resistivity is being calculated.
    /// When set, the value is stored to `UserDefaults`.
    @Published var thickness: Double {
        didSet { UserDefaults.standard.set(thickness, forKey: "thickness") }
    }
    
    /// A correction factor applied to the thickness during resistivity calculation.
    /// When set, the value is stored to `UserDefaults`.
    @Published var thicknessCorrectionFactor: Double {
        didSet { UserDefaults.standard.set(thicknessCorrectionFactor, forKey: "thicknessCorrectionFactor") }
    }
    
    /// A correction factor applied for finite width during resistivity calculation.
    /// When set, the value is stored to `UserDefaults`.
    @Published var finiteWidthCorrectionFactor: Double {
        didSet { UserDefaults.standard.set(finiteWidthCorrectionFactor, forKey: "finiteWidthCorrectionFactor") }
    }
    
    /// The units used for displaying resistivity measurements.
    /// When set, the value is stored to `UserDefaults`.
    @Published var resistivityUnits: ResistivityUnits {
        didSet {
            UserDefaults.standard.set(resistivityUnits, forKey: "resistivityUnits")
        }
    }
    
    
    @Published var thicknessUnits: LengthUnits = .millimeter {
        didSet {
            UserDefaults.standard.set(thicknessUnits.rawValue, forKey: "resistivityUnits")
        }
    }
    
    
    /// Initializes a new `ResistivityMeasurementSettings` instance, loading persisted values from `UserDefaults`.
    init() {
        shouldCalculateResistivity = UserDefaults.standard.object(forKey: "shouldCalculateResistivity") as? Bool ?? false
        thickness = UserDefaults.standard.object(forKey: "thickness") as? Double ?? 0.001
        thicknessCorrectionFactor = UserDefaults.standard.object(forKey: "thicknessCorrectionFactor") as? Double ?? 1.0
        finiteWidthCorrectionFactor = UserDefaults.standard.object(forKey: "finiteWidthCorrectionFactor") as? Double ?? 1.0
        resistivityUnits = UserDefaults.standard.object(forKey: "resistivityUnits") as? ResistivityUnits ?? .ohm_meters
        
        if let thicknessUnitsStored = UserDefaults.standard.object(forKey: "thicknessUnits") as? String {
            thicknessUnits = LengthUnits(rawValue: thicknessUnitsStored) ?? .millimeter
        } else {
            thicknessUnits = .millimeter
        }
    }
}

/// Extension to `ResistivityMeasurementSettings` conforming to the `Info` protocol.
extension ResistivityMeasurementSettings: Info {
    /// The type of information that will be provided.
    typealias Output = ResistivityMeasurementInfo
    
    /// Generates a `ResistivityMeasurementInfo` object containing the current settings.
    /// - Returns: A `ResistivityMeasurementInfo` instance with the current settings.
    func info() -> Output {
        // TODO: Test Change
        // let thicknessInMeters = thickness * thicknessUnits.scaleFactor()
        let thicknessInMeters = thicknessUnits.scaledToBaseMeters(thickness)
        
        let info = ResistivityMeasurementInfo(shouldCalculateResistivity: shouldCalculateResistivity,
                                              thickness: thicknessInMeters,
                                              thicknessCorrectionFactor: thicknessCorrectionFactor,
                                              finiteWidthCorrectionFactor: finiteWidthCorrectionFactor)
        
        return info
    }
}

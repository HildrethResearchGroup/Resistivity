//
//  UnitsSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/31/23.
//

import Foundation
import SwiftUI

/// `UnitsSettings` is a class that manages the user's settings for units of resistance and resistivity.
/// It conforms to `ObservableObject` to allow SwiftUI views to react to changes in these settings.
class UnitsSettings: ObservableObject {
    /// The selected units for resistance, persisted in `UserDefaults` and updated across the app.
    @Published var resistanceUnits: ResistanceUnits {
        didSet {
            UserDefaults.standard.set(resistanceUnits, forKey: "resistanceUnits")
            resistanceUnitsUpdated()
        }
    }
    
    /// The selected units for resistivity, persisted in `UserDefaults` and updated across the app.
    @Published var resistivityUnits: ResistivityUnits {
        didSet {
            UserDefaults.standard.set(resistivityUnits, forKey: "resistivityUnits")
            resistivityUnitsUpdated()
        }
    }
    
    /// Initializes a new `UnitsSettings` object, loading saved units from `UserDefaults` or setting default values.
    init() {
        let localResistanceUnits = UserDefaults.standard.object(forKey: "resistanceUnits") as? ResistanceUnits ?? .ohms
        
        resistanceUnits = localResistanceUnits
        resistanceScaleFactor = localResistanceUnits.scaleFactor()
        resistanceUnitsDisplay = String(localResistanceUnits.description)
        
        
        let localResistivityUnits = UserDefaults.standard.object(forKey: "resistivityUnits") as? ResistivityUnits ?? .ohm_meters
        resistivityUnits = localResistivityUnits
        resistivityScaleFactor = localResistivityUnits.scaleFactor()
        resistivityUnitsDisplay = localResistivityUnits.description
    }
    
    /// The scale factor used to convert resistance values to the selected units.
    private var resistanceScaleFactor: Double
    /// A string representation of the selected resistance units for display purposes.
    private var resistanceUnitsDisplay: String
    
    /// The scale factor used to convert resistivity values to the selected units.
    private var resistivityScaleFactor: Double
    /// A string representation of the selected resistivity units for display purposes.
    private var resistivityUnitsDisplay: String

}


extension UnitsSettings {
    
    /// Updates the scale factor and display string for resistance units when they are changed.
    private func resistanceUnitsUpdated() {
        resistanceScaleFactor = resistanceUnits.scaleFactor()
        resistanceUnitsDisplay = String(resistanceUnits.description)
    }
    
    /// Updates the scale factor and display string for resistivity units when they are changed.
    private func resistivityUnitsUpdated() {
        resistivityScaleFactor = resistivityUnits.scaleFactor()
        resistivityUnitsDisplay = resistivityUnits.description
    }
    
    /// Returns the resistance value scaled according to the selected units.
    /// - Parameter valueIn: The resistance value to be scaled.
    /// - Returns: The scaled resistance value.
    func scaledResistance(_ valueIn: Double) -> Double {  valueIn * resistanceScaleFactor  }
    
    /// Returns the resistivity value scaled according to the selected units.
    /// - Parameter valueIn: The resistivity value to be scaled.
    /// - Returns: The scaled resistivity value.
    func scaledResistivity(_ valueIn: Double) -> Double {  valueIn * resistivityScaleFactor  }
}

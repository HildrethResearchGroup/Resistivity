//
//  UnitsSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/31/23.
//

import Foundation
import SwiftUI

class UnitsSettings: ObservableObject {
    @Published var resistanceUnits: ResistanceUnits {
        didSet {
            UserDefaults.standard.set(resistanceUnits, forKey: "resistanceUnits")
            resistanceUnitsUpdated()
        }
    }
    
    
    @Published var resistivityUnits: ResistivityUnits {
        didSet {
            UserDefaults.standard.set(resistivityUnits, forKey: "resistivityUnits")
            resistivityUnitsUpdated()
        }
    }
    
    
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
    
    private var resistanceScaleFactor: Double
    private var resistanceUnitsDisplay: String
    
    private var resistivityScaleFactor: Double
    private var resistivityUnitsDisplay: String

}


extension UnitsSettings {
    
    private func resistanceUnitsUpdated() {
        resistanceScaleFactor = resistanceUnits.scaleFactor()
        resistanceUnitsDisplay = String(resistanceUnits.description)
    }
    
    private func resistivityUnitsUpdated() {
        resistivityScaleFactor = resistivityUnits.scaleFactor()
        resistivityUnitsDisplay = resistivityUnits.description
    }
    
    func scaledResistance(_ valueIn: Double) -> Double {  valueIn * resistanceScaleFactor  }
    
    func scaledResistivity(_ valueIn: Double) -> Double {  valueIn * resistivityScaleFactor  }
}

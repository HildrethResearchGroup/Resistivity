//
//  MeasurementSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

class ResistivityMeasurementSettings: ObservableObject {
    var id = UUID()
    
    var shouldCalculateResistivity: Bool {
        get {  UserDefaults.standard.object(forKey: "shouldCalculateResistivity") as? Bool ?? false   }
        
        set {  UserDefaults.standard.set(newValue, forKey: "shouldCalculateResistivity")  }
    }
    
    var thickness: Double {
        get {  UserDefaults.standard.object(forKey: "thickness") as? Double ?? 0.001   }
        
        set {  UserDefaults.standard.set(newValue, forKey: "thickness")  }
    }
    
    var thicknessCorrectionFactor: Double {
        get {  UserDefaults.standard.object(forKey: "thicknessCorrectionFactor") as? Double ?? 1.0   }
        
        set {  UserDefaults.standard.set(newValue, forKey: "thicknessCorrectionFactor")  }
    }
    
    var finiteWidthCorrectionFactor: Double {
        
        get {  UserDefaults.standard.object(forKey: "finiteWidthCorrectionFactor") as? Double ?? 1.0   }
        
        set {  UserDefaults.standard.set(newValue, forKey: "finiteWidthCorrectionFactor")  }
        
    }
    

    
}

extension ResistivityMeasurementSettings: Info {
    typealias Output = ResistivityMeasurementInfo
    
   
    func info() -> Output {
        let info = ResistivityMeasurementInfo(shouldCalculateResistivity: shouldCalculateResistivity,
                                                     thickness: thickness,
                                                     thicknessCorrectionFactor: thicknessCorrectionFactor,
                                                     finiteWidthCorrectionFactor: finiteWidthCorrectionFactor)
        
        return info
    }
}



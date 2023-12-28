//
//  MeasurementSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

class ResistivityMeasurementSettings: ObservableObject {
    var id = UUID()
    
    @Published var shouldCalculateResistivity: Bool {
        didSet {  UserDefaults.standard.set(shouldCalculateResistivity, forKey: "shouldCalculateResistivity")   }
    }
    
    @Published var thickness: Double {
        didSet {  UserDefaults.standard.set(thickness, forKey: "thickness")  }
    }
    
    @Published var thicknessCorrectionFactor: Double {
        didSet {  UserDefaults.standard.set(thicknessCorrectionFactor, forKey: "thicknessCorrectionFactor")  }
    }
    
    @Published var finiteWidthCorrectionFactor: Double {
        
        didSet {  UserDefaults.standard.set(finiteWidthCorrectionFactor, forKey: "finiteWidthCorrectionFactor")  }
        
    }
    
    
    init() {
        shouldCalculateResistivity = UserDefaults.standard.object(forKey: "shouldCalculateResistivity") as? Bool ?? false
        
        thickness = UserDefaults.standard.object(forKey: "thickness") as? Double ?? 0.001
        
        thicknessCorrectionFactor = UserDefaults.standard.object(forKey: "thicknessCorrectionFactor") as? Double ?? 1.0
        
        finiteWidthCorrectionFactor = UserDefaults.standard.object(forKey: "finiteWidthCorrectionFactor") as? Double ?? 1.0
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



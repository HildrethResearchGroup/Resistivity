//
//  MeasurementSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

struct ResistivityMeasurementSettings {
    var id = UUID()
    
    var shouldCalculateResistivity: Bool = false
    var thickness: Double = 1.0
    var thicknessCorrectionFactor: Double = 1.0
    var finiteWidthCorrectionFactor: Double = 1.0
    
    private var t: Double { return thickness }
    private var f1: Double { return thicknessCorrectionFactor }
    private var f2: Double { return finiteWidthCorrectionFactor }
    
    init(thickness: Double, thicknessCorrectionFactor: Double, finiteWidthCorrectionFactor: Double) {
        self.thickness = thickness
        self.thicknessCorrectionFactor = thicknessCorrectionFactor
        self.finiteWidthCorrectionFactor = finiteWidthCorrectionFactor
    }
    
    func save() {
        UserDefaults.standard.set(t, forKey: "rc-t")
        UserDefaults.standard.set(f1, forKey: "rc-f1")
        UserDefaults.standard.set(f2, forKey: "rc-f2")
    }
    
    init() {
        if let t = UserDefaults.standard.object(forKey: "rc-t") as? Double {
            thickness = t
        } else {
            thickness = 1.0
        }
        if let f1 = UserDefaults.standard.object(forKey: "rc-f1") as? Double {
            thicknessCorrectionFactor = f1
        } else {
            thicknessCorrectionFactor = 1.0
        }
        if let f2 = UserDefaults.standard.object(forKey: "rc-f2") as? Double {
            finiteWidthCorrectionFactor = f2
        } else {
            finiteWidthCorrectionFactor = 1.0
        }
    }
}


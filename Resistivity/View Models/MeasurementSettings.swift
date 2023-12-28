//
//  MeasurementSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/24/23.
//

import Foundation

class MeasurementSettings: ObservableObject {
    var id = UUID()
    
    var numberOfMeasurements: Int {
        get {  _numberOfMeasurements   }
        
        set {
            if newValue <= 0 {
                _numberOfMeasurements = 1
            } else {
                _numberOfMeasurements = newValue
            }
        }
    }
    
    
    
    var timeBetweenMeasurements: Double {
        get { _timeBetweenMeasurements }
        
        set {
            if newValue.sign == .minus || newValue == .zero {
                _timeBetweenMeasurements = 1
            } else {
                _timeBetweenMeasurements = newValue
            }
            
            
        }
    }
    
    @Published private var _timeBetweenMeasurements: Double
    @Published private var _numberOfMeasurements: Int
    
    init() {
        _numberOfMeasurements = UserDefaults.standard.object(forKey: "numberOfMeasurements") as? Int ?? 1
        _timeBetweenMeasurements = UserDefaults.standard.object(forKey: "timeBetweenMeasurements") as? Double  ?? 1.0
        
    }
}

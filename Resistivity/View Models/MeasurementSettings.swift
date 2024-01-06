//
//  MeasurementSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/24/23.
//

import Foundation

/// `MeasurementSettings` is a class that manages the settings related to measurements in the Resistivity app.
/// It conforms to `ObservableObject` to allow SwiftUI views to react to changes in settings.
class MeasurementSettings: ObservableObject {
    /// Unique identifier for the measurement settings, useful for distinguishing between instances.
    var id = UUID()
    
    /// The number of measurements to be taken.
    /// It is a computed property that ensures the value is always greater than zero and persists the value to `UserDefaults`.
    var numberOfMeasurements: Int {
        get {  _numberOfMeasurements   }
        
        set {
            // Ensure the number of measurements is at least 1.
            if newValue <= 0 {
                _numberOfMeasurements = 1
            } else {
                _numberOfMeasurements = newValue
            }
            
            // Save the new value to UserDefaults for persistence.
            UserDefaults.standard.set(_numberOfMeasurements, forKey: "numberOfMeasurements")
        }
    }
    
    /// The time interval in seconds between measurements.
    /// It is a computed property that ensures the value is positive and persists the value to `UserDefaults`.
    var timeBetweenMeasurements: Double {
        get { _timeBetweenMeasurements }
        
        set {
            // Ensure the time between measurements is at least 1 second.
            if newValue.sign == .minus || newValue == .zero {
                _timeBetweenMeasurements = 1
            } else {
                _timeBetweenMeasurements = newValue
            }
            
            // Save the new value to UserDefaults for persistence.
            UserDefaults.standard.set(_timeBetweenMeasurements, forKey: "timeBetweenMeasurements")
        }
    }
    
    /// The units used for resistance measurements.
    /// It is a published property to notify views of changes and persists the value to `UserDefaults`.
    @Published var resistanceUnits: ResistanceUnits {
        didSet {
            // Save the new value to UserDefaults for persistence.
            UserDefaults.standard.set(resistanceUnits, forKey: "resistanceUnits")
        }
    }
    
    /// Private storage for the time interval between measurements.
    /// It is a published property to enable SwiftUI views to update when the value changes.
    @Published private var _timeBetweenMeasurements: Double
    
    /// Private storage for the number of measurements.
    /// It is a published property to enable SwiftUI views to update when the value changes.
    @Published private var _numberOfMeasurements: Int
    
    /// Initializes a new instance of `MeasurementSettings`.
    /// It loads persisted settings from `UserDefaults` or sets default values if none are found.
    init() {
        // Load the number of measurements from UserDefaults or use a default value of 1.
        _numberOfMeasurements = UserDefaults.standard.object(forKey: "numberOfMeasurements") as? Int ?? 1
        
        // Load the time between measurements from UserDefaults or use a default value of 1.0 seconds.
        _timeBetweenMeasurements = UserDefaults.standard.object(forKey: "timeBetweenMeasurements") as? Double  ?? 1.0
        
        // Load the resistance units from UserDefaults or use a default value of .ohms.
        resistanceUnits = UserDefaults.standard.object(forKey: "resistanceUnits") as? ResistanceUnits ?? .ohms
    }
}

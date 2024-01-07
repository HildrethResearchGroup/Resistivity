//
//  LineResistanceSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation

/// `LineResistanceSettings` is a class that manages the settings related to calculating line resistance.
/// It conforms to `ObservableObject` to allow SwiftUI views to react to changes in settings.
class LineResistanceSettings: ObservableObject {
    
    /// A boolean value that determines whether line resistance calculation should be performed.
    /// When set, it updates the corresponding value in `UserDefaults`.
    @Published var shouldCalculateLineResistance: Bool {
        didSet {  UserDefaults.standard.set(shouldCalculateLineResistance, forKey: "shouldCalculateLineResistance")  }
    }
    
    /// A double value representing the gap between voltage sensing points.
    /// When set, it updates the corresponding value in `UserDefaults`.
    @Published var voltageSensingGap: Double {
        didSet {  UserDefaults.standard.set(voltageSensingGap, forKey: "voltageSensingGap")  }
    }
    
    /// Initializes a new `LineResistanceSettings` instance, loading initial values from `UserDefaults`.
    init() {
        voltageSensingGap = UserDefaults.standard.object(forKey: "voltageSensingGap") as? Double ?? 20.0
        shouldCalculateLineResistance = UserDefaults.standard.object(forKey: "shouldCalculateLineResistance") as? Bool ?? false
    }
}

/// Extension of `LineResistanceSettings` to conform to the `Info` protocol.
extension LineResistanceSettings: Info {
    /// The type of information that this settings class will output.
    typealias Output = LineResistanceInfo
    
    /// Generates an `Output` instance containing the current settings related to line resistance.
    /// - Returns: An instance of `LineResistanceInfo` populated with the current settings.
    func info() -> Output {
        let info = LineResistanceInfo(shouldCalculateLineResistance: shouldCalculateLineResistance, voltageSensingGap: voltageSensingGap)
        
        return info
    }
}

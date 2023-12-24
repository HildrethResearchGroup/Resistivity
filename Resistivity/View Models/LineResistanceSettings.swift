//
//  LineResistanceSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation


class LineResistanceSettings: ObservableObject {
    
    var shouldCalculateLineResistance: Bool {
        get {  UserDefaults.standard.object(forKey: "shouldCalculateLineResistance") as? Bool ?? false   }
        
        set {  UserDefaults.standard.set(newValue, forKey: "shouldCalculateLineResistance")  }
    }
    
    var voltageSensingGap: Double? {
        get {  UserDefaults.standard.object(forKey: "voltageSensingGap") as? Double    }
        
        set {  UserDefaults.standard.set(newValue, forKey: "voltageSensingGap")  }
    }
}

extension LineResistanceSettings: Info {
    typealias Output = LineResistanceInfo
    
    func info() -> Output {
        let info = LineResistanceInfo(shouldCalculateLineResistance: shouldCalculateLineResistance, voltageSensingGap: voltageSensingGap)
        
        return info
    }
}


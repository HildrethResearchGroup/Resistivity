//
//  LineResistanceSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation


class LineResistanceSettings: ObservableObject {
    
    var shouldCalculateLineResistance: Bool {
        didSet {  UserDefaults.standard.set(shouldCalculateLineResistance, forKey: "shouldCalculateLineResistance")  }
    }
    
    var voltageSensingGap: Double {
        didSet {  UserDefaults.standard.set(voltageSensingGap, forKey: "voltageSensingGap")  }
    }
    
    init() {
        voltageSensingGap = UserDefaults.standard.object(forKey: "voltageSensingGap") as? Double ?? 20.0
        shouldCalculateLineResistance = UserDefaults.standard.object(forKey: "shouldCalculateLineResistance") as? Bool ?? false
    }
}

extension LineResistanceSettings: Info {
    typealias Output = LineResistanceInfo
    
    func info() -> Output {
        let info = LineResistanceInfo(shouldCalculateLineResistance: shouldCalculateLineResistance, voltageSensingGap: voltageSensingGap)
        
        return info
    }
}


//
//  SampleSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation

class SampleSettings: ObservableObject, Identifiable {
    var id = UUID()
    
    @Published var name = "" {
        didSet {  UserDefaults.standard.set(name, forKey: "sampleSettings.name")  }
    }
    
    init() {
        name = UserDefaults.standard.object(forKey: "sampleSettings.name") as? String ?? ""
    }
    
}


extension SampleSettings: Info {
    typealias Output = SampleInfo
    
    func info() -> SampleInfo {
        let info = SampleInfo(name: self.name)
        
        return info
    }
}

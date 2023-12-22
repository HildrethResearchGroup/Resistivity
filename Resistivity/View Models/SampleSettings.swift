//
//  SampleSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation

class SampleSettings: ObservableObject, Identifiable {
    var id = UUID()
    
    @Published var name = ""
    
}


extension SampleSettings: Info {
    typealias Output = SampleInfo
    
    func info() -> Output {
        let info = SampleInfo(name: self.name)
        
        return info
    }
}

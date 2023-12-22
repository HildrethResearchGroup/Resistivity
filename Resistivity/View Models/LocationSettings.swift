//
//  LocationSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation


class LocationSettings: ObservableObject, Identifiable {
    var id = UUID()
    @Published var name = ""
    
}


extension LocationSettings: Info {
    typealias Output = LocationInfo
    
    
    func info() -> LocationInfo {
        return LocationInfo(name: self.name)
    }
}

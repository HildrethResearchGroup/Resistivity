//
//  LocationSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation


class LocationSettings: ObservableObject, Identifiable {
    var id = UUID()
    @Published var name = "" {
        didSet {  UserDefaults.standard.set(name, forKey: "locationSettings.name")  }
    }
    
    init() {
        name = UserDefaults.standard.object(forKey: "locationSettings.name") as? String ?? ""
    }
    
}


extension LocationSettings: Info {
    typealias Output = LocationInfo
    
    
    func info() -> LocationInfo {
        return LocationInfo(name: self.name)
    }
}

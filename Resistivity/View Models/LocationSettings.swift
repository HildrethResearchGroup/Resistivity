//
//  LocationSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation


class LocationSettings: ObservableObject, Identifiable {
    var id = UUID()
    var name = ""
    
    
    var locationNumber: Int = 0
}

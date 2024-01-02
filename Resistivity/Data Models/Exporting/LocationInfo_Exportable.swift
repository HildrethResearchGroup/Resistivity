//
//  LocationInfo_Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation


extension LocationInfo: Exportable {
    func header() -> [String] {
        return ["Location Name",
                "Location Number",
                "Location Measurement Number"]
    }
    
    
    func data() -> [String] {
        return [name,
                String(locationNumber),
                String(measurementNumber) ]
    }
}

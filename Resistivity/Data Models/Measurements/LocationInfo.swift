//
//  LocationInformation.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

struct LocationInfo {
    var id = UUID()
    var name = ""
}

extension LocationInfo: Codable, Identifiable, Equatable {}

extension LocationInfo {
    init(_ nameIn: String) {
        name = nameIn
    }
}

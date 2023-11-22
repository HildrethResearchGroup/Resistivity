//
//  SampleInformation.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

struct SampleInfo {
    var id = UUID()
    var name = ""
}

extension SampleInfo: Codable, Identifiable {}

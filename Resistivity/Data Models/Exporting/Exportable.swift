//
//  Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

protocol Exportable {
    func header() -> [String]
    
    func data() -> [String]
}

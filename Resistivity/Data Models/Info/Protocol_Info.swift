//
//  Protocol_Info.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation


protocol Info {
    associatedtype Output
    
    func info() -> Output
}

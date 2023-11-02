//
//  VISAInstrumentProtocol.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/6/23.
//

import Foundation

protocol VISAInstrumentProtocol {
    init?(ipAddress: String, port: Int) async
    
    func getIdentifier() async throws -> String
}

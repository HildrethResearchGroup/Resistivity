//
//  SimulatedNanoVoltMeterController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/29/23.
//

import Foundation
import CoreSwiftVISA

actor SimulatedNanoVoltMeterController: OmhMeterControllerProtocol {
    static var minimumDelay: UInt32 = 1_000_000
    
    var returnMode: ReturnMode
    
    init?(ipAddress: String, port: Int) async {
        returnMode = .identifier
    }
    
    func getIdentifier() async throws -> String {
        return "Simulated Ohm Meter"
    }
    
    func getResistance() async throws -> Double {
        return Double.random(in: 1.0e-4...1.9e-4)
    }
    
    func flushData() async {
        
    }
}

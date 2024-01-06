//
//  SimulatedNanoVoltMeterController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/29/23.
//

import Foundation
import CoreSwiftVISA

/// An actor that simulates a nanovolt meter controller conforming to the `OmhMeterControllerProtocol`.
/// This simulated controller can be used for testing purposes where actual hardware is not available.
actor SimulatedNanoVoltMeterController: OmhMeterControllerProtocol {
    /// The minimum delay between commands to simulate the response time of a real device.
    static var minimumDelay: UInt32 = 1_000_000
    
    /// The mode in which the simulated meter returns data.
    var returnMode: ReturnMode
    
    /// Initializes a new instance of the simulated nanovolt meter controller.
    /// - Parameters:
    ///   - ipAddress: The IP address of the simulated device (unused in simulation).
    ///   - port: The port number of the simulated device (unused in simulation).
    /// - Returns: An optional `SimulatedNanoVoltMeterController` instance.
    init?(ipAddress: String, port: Int) async {
        returnMode = .identifier
    }
    
    /// Retrieves the identifier of the simulated meter.
    /// - Returns: A `String` representing the identifier of the simulated meter.
    func getIdentifier() async throws -> String {
        return "Simulated Ohm Meter"
    }
    
    /// Retrieves a simulated resistance value.
    /// - Returns: A `Double` representing the simulated resistance in ohms.
    func getResistance() async throws -> Double {
        return Double.random(in: 1.0e-4...1.9e-4)
    }
    
    /// Flushes any pending data in the simulated meter. This is a no-op in the simulation.
    func flushData() async {
        
    }
}

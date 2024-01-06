//
//  NanoVoltMeterController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import Foundation

/// A protocol defining the interface for a nano-voltmeter controller.
/// Conforming to this protocol allows an object to act as a controller for a nano-voltmeter,
/// providing functionality to measure resistance and manage the data buffer.
protocol OmhMeterControllerProtocol: Actor, VISAInstrumentProtocol {
    /// The minimum delay between measurements to ensure accurate readings.
    static var minimumDelay: UInt32 { get }
    
    /// The mode in which the measurement results are returned.
    var returnMode: ReturnMode { get set }
    
    /// Retrieves the resistance measurement from the nano-voltmeter.
    /// - Returns: A `Double` representing the measured resistance in ohms.
    /// - Throws: An error if the measurement cannot be completed or if the device is not responding.
    func getResistance() async throws -> Double
    
    /// Flushes the data buffer of the nano-voltmeter, clearing any stored measurements.
    func flushData() async
}

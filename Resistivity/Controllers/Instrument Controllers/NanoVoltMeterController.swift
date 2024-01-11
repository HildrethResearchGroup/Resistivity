//
//  DefaultNanoVoltMeterController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import Foundation
import CoreSwiftVISA
import SwiftVISASwift

/// An actor that conforms to `OmhMeterControllerProtocol` to control a nanovoltmeter instrument.
/// It is responsible for managing the communication with the instrument and performing measurements.
actor NanoVoltMeterController: OmhMeterControllerProtocol {

    /// The minimum delay in microseconds between queries to ensure that the instrument has enough time to process and respond.
    static var minimumDelay: UInt32 = 2_000_000
    
    /// The message-based instrument that represents the physical nanovoltmeter.
    var instrument: MessageBasedInstrument
    
    /// The mode that determines the type of data the instrument should return.
    var returnMode: ReturnMode {
        willSet {
            if newValue != returnMode {
                Task {
                    await flushOldData(for: newValue)
                }
            }
        }
    }
    
    /// Initializes a new `NanoVoltMeterController` with the given IP address and port.
    /// - Parameters:
    ///   - ipAddress: The IP address of the instrument.
    ///   - port: The port number to connect to the instrument.
    /// - Returns: An optional `NanoVoltMeterController` which will be nil if the instrument cannot be created.
    init?(ipAddress: String, port: Int) async {
        
        let manager = InstrumentManager.shared
        
        // Attempt to create an instrument with the given IP address and port.
        guard let instrument = try? await manager.instrumentAt(address: ipAddress, port: port) else {
            print("Could not create an instrument at: \(ipAddress) and port: \(port)")
            return nil
        }
        
        self.instrument = instrument
        
        self.returnMode = .identifier
        
        // Flush old data for the current return mode to ensure accurate readings.
        await flushOldData(for: returnMode)
        
        // Retrieve and print the instrument identifier.
        let info = try? await getIdentifier()
    }
    
    // MARK: - Interface
    
    /// Retrieves the identifier of the instrument.
    /// - Returns: A string containing the identifier of the instrument.
    func getIdentifier() async throws -> String {
        returnMode = .identifier
        
        let identifier = try await instrument.query("*IDN?\n", as: String.self, using: StringDecoder())
        
        return identifier
    }
    
    /// Measures and retrieves the resistance value from the instrument.
    /// - Returns: A `Double` representing the resistance measured by the instrument.
    func getResistance() async throws -> Double {
        returnMode = .resistivity
        
        let resistance = try await instrument.query("MEAS:FRES?\n", as: Double.self, using: ExponentDecoder())
        
        return resistance
    }
    
    // MARK: - Internals
    
    /// Flushes old data from the instrument by querying new data until the instrument returns data compatible with the new `returnMode`.
    /// - Parameter returnMode: The `ReturnMode` for which the old data should be flushed.
    func flushOldData(for returnMode: ReturnMode) async {
        switch returnMode {
        case .identifier:
            for _ in 0..<3 {
                _ = try? await instrument.query("*IDN?\n", as: String.self)
                usleep(NanoVoltMeterController.minimumDelay)
            }
        case .resistivity:
            for _ in 0..<3 {
                _ = try? await instrument.query("MEAS:FRES?\n", as: String.self)
                usleep(NanoVoltMeterController.minimumDelay)
            }
        }
    }
    
    /// Flushes old data from the instrument specifically for the resistivity return mode.
    func flushData() async {
        await flushOldData(for: .resistivity)
    }
    
    // MARK: - Decoding
    
    /// A `MessageDecoder` that decodes a string message into a `Double`.
    struct DoubleDecoder: MessageDecoder {
        /// Decodes a string into a `Double`.
        /// - Parameter string: The string to be decoded.
        /// - Returns: A `Double` representation of the string.
        /// - Throws: `DecoderError.doubleCouldNotBeDecoded` if the string cannot be converted to a `Double`.
        func decode(_ string: String) throws -> Double {
            let fixedString = try StringDecoder().decode(string)
            
            guard let result = Double(fixedString) else {
                throw DecoderError.doubleCouldNotBeDecoded
            }
            
            return result
        }
    }
    
    /// An enumeration of errors that can occur during the decoding process.
    enum DecoderError: Error {
        case doubleCouldNotBeDecoded
        case stringCouldNotBeDecoded
    }
    
}

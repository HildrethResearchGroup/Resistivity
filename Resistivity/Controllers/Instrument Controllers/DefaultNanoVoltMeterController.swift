//
//  DefaultNanoVoltMeterController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import Foundation
import CoreSwiftVISA
import SwiftVISASwift

actor DefaultNanoVoltMeterController: NanoVoltMeterController {

    static var minimumDelay: UInt32 = 2_000_000
    
    private var instrument: MessageBasedInstrument
    
    var returnMode: ReturnMode {
        willSet {
            if newValue != returnMode {
                Task {
                    await flushOldData(for: newValue)
                }
            }
        }
    }
    
    init?(ipAddress: String, port: Int) async {
        
        let manager = InstrumentManager.shared
        
        
        guard let instrument = try? await manager.instrumentAt(address: ipAddress, port: port) else {
            return nil
        }
        
        self.instrument = instrument
        
        self.returnMode = .identifier
        
        await flushOldData(for: returnMode)
    }
    
    
    // MARK: - Interface
    func getIdentifier() async throws -> String {
        returnMode = .identifier
        
        let identifier = try await instrument.query("*IDN?\n", as: String.self, using: StringDecoder())
        
        return identifier
    }
    
    func getResistance() async throws -> Double {
        returnMode = .resistivity
        
        let resistance = try await instrument.query("MEAS:FRES?\n", as: Double.self, using: DoubleDecoder())
        
        return resistance
    }
    
    
    
    // MARK: - Internals
    
    // The instrument often sends back old data − to make sure that the old data is at least compatible with the new data, query some new data until new data will be returned
    func flushOldData(for returnMode: ReturnMode) async {
        switch returnMode {
        case .identifier:
            for _ in 0..<3 {
                _ = try? await instrument.query("*IDN?\n", as: String.self)
                usleep(DefaultNanoVoltMeterController.minimumDelay)
            }
        case .resistivity:
            for _ in 0..<3 {
                _ = try? await instrument.query("MEAS:FRES?\n", as: String.self)
                usleep(DefaultNanoVoltMeterController.minimumDelay)
            }
        }
    }
    
    func flushData() async {
        await flushOldData(for: .resistivity)
    }
    
    
    // MARK: - Decoding
    struct DoubleDecoder: MessageDecoder {
        func decode(_ string: String) throws -> Double {
            let fixedString = try StringDecoder().decode(string)
            
            guard let result = Double(fixedString) else {
                throw DecoderError.doubleCouldNotBeDecoded
            }
            

            return result
            
        }
    }
    
    
    private struct StringDecoder: MessageDecoder {
        func decode(_ string: String) throws -> String {
            var fixedString = string
            
            if string.hasPrefix("1`") {
                fixedString = String(string.dropFirst(2))
            }
            
            while fixedString.hasSuffix("\n") {
                fixedString = String(fixedString.dropLast())
            }
            
            return fixedString
        }
    }
    
    enum DecoderError: Error {
        case doubleCouldNotBeDecoded
        case stringCouldNotBeDecoded
    }
    
}

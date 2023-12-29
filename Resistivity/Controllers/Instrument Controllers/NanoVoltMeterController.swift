//
//  DefaultNanoVoltMeterController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import Foundation
import CoreSwiftVISA
import SwiftVISASwift

actor NanoVoltMeterController: OmhMeterControllerProtocol {

    static var minimumDelay: UInt32 = 2_000_000
    
    var instrument: MessageBasedInstrument
    
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
            print("Could not create an instrument at: \(ipAddress) and port: \(port)")
            return nil
        }
        
        self.instrument = instrument
        
        self.returnMode = .identifier
        
        await flushOldData(for: returnMode)
        
        let info = try? await getIdentifier()
        print(info ?? "Info not available")
    }
    
    
    // MARK: - Interface
    func getIdentifier() async throws -> String {
        returnMode = .identifier
        
        let identifier = try await instrument.query("*IDN?\n", as: String.self, using: StringDecoder())
        
        return identifier
    }
    
    func getResistance() async throws -> Double {
        returnMode = .resistivity
        
        let resistance = try await instrument.query("MEAS:FRES?\n", as: Double.self, using: ExponentDecoder())
        
        return resistance
    }
    
    
    
    // MARK: - Internals
    
    // The instrument often sends back old data − to make sure that the old data is at least compatible with the new data, query some new data until new data will be returned
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
    
    
    
    enum DecoderError: Error {
        case doubleCouldNotBeDecoded
        case stringCouldNotBeDecoded
    }
    
}




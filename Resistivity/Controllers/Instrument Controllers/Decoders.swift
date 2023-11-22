//
//  Decoders.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import Foundation
import CoreSwiftVISA


extension NanoVoltMeterController {
    
    struct StringDecoder: MessageDecoder {
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
    
    struct ExponentDecoder: MessageDecoder {
        
        func decode(_ message: String) throws -> Double {
            print("Decoding")
            print("Message = \(message)")
            
            var fixedString = message
            if message.hasPrefix("1'") {
                fixedString = String(message.dropFirst(2))
            }
            
            while fixedString.hasSuffix("\n") {
                fixedString = String(fixedString.dropLast())
            }
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .scientific
            
            guard let value = numberFormatter.number(from: fixedString) else  {
                throw ExponentDecoderError.couldNotFormatNumberFromString
            }
            
            let doubleValue = Double(truncating: value)
            
            return doubleValue
        }
        
        
        enum ExponentDecoderError: Error {
            case couldNotFormatNumberFromString
        }
        
    }
    
}

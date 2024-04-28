//
//  Decoders.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import Foundation
import CoreSwiftVISA

/// Extension of `NanoVoltMeterController` to include custom decoders for messages.
extension NanoVoltMeterController {
    
    /// A decoder that processes strings received from the NanoVoltMeter.
    struct StringDecoder: MessageDecoder {
        
        /// Decodes a given string by removing specific prefixes and suffixes.
        /// - Parameter string: The string to be decoded.
        /// - Returns: A cleaned string with removed prefixes and newlines.
        /// - Throws: Can throw an error if the decoding process fails.
        func decode(_ string: String) throws -> String {
            var fixedString = string
            
            // If the string starts with "1`", remove this prefix.
            if string.hasPrefix("1`") {
                fixedString = String(string.dropFirst(2))
            }
            
            // Remove all newline characters from the end of the string.
            while fixedString.hasSuffix("\n") {
                fixedString = String(fixedString.dropLast())
            }
            
            return fixedString
        }
    }
    
    /// A decoder that interprets strings representing scientific notation numbers.
    struct ExponentDecoder: MessageDecoder {
        
        /// Decodes a message containing a number in scientific notation.
        /// - Parameter message: The string message to be decoded.
        /// - Returns: A `Double` value represented by the string.
        /// - Throws: `ExponentDecoderError.couldNotFormatNumberFromString` if the string cannot be formatted to a number.
        func decode(_ message: String) throws -> Double {
            
            var fixedString = message
            
            // If the message starts with "1'", remove this prefix.
            if message.hasPrefix("1'") {
                fixedString = String(message.dropFirst(2))
            }
            
            // Remove all newline characters from the end of the string.
            while fixedString.hasSuffix("\n") {
                fixedString = String(fixedString.dropLast())
            }
            
            // Remove all "+" characters otherwise the decorder fails.
            while fixedString.hasPrefix("+") {
                fixedString = String(fixedString.dropFirst())
            }
            
            // Configure a number formatter for scientific notation.
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .scientific
            
            // Attempt to convert the string to a number using the formatter.
            guard let value = numberFormatter.number(from: fixedString) else  {
                throw ExponentDecoderError.couldNotFormatNumberFromString(message)
            }
            
            // Convert the NSNumber to a native Swift Double.
            let doubleValue = Double(truncating: value)
            
            return doubleValue
        }
        
        /// Errors that can be thrown by the `ExponentDecoder`.
        enum ExponentDecoderError: Error {
            /// Error indicating that the string could not be formatted to a number.
            case couldNotFormatNumberFromString(String)
        }
        
    }
    
}

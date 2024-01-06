//
//  ReturnMode.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import Foundation

/// `ReturnMode` is an enumeration that specifies the type of value to be returned by a function or method.
/// It is used to control the output format, allowing the caller to specify whether they want an identifier or a resistivity value.
///
/// - identifier: A case indicating that an identifier (likely a string or unique identifier) should be returned.
/// - resistivity: A case indicating that a resistivity value (likely a numerical value representing electrical resistivity) should be returned.
enum ReturnMode {
    case identifier
    case resistivity
}

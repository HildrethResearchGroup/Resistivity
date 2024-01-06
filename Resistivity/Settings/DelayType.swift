//
//  DelayType.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation

/// `DelayType` is an enumeration that represents the type of delay used in the context of the Resistivity application.
/// It can either be a simple delay or a time interval.
///
/// - `delay`: Represents a simple delay where the duration is not specified by a start and end time, but rather a single duration.
/// - `timeInterval`: Represents a time interval with a specific start and end time.
enum DelayType: Int, Codable {
    case delay
    case timeInterval
}

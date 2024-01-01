//
//  LocationInfo.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/22/23.
//

import Foundation

/// `LocationInfo` is a structure that represents the information about a specific location
/// where a resistivity measurement is taken. It includes a unique identifier, a name for the location,
/// and counters for the location number and measurement number.
struct LocationInfo {
    /// A unique identifier for the location, automatically generated upon creation.
    var id = UUID()
    
    /// A human-readable name for the location.
    var name: String
    
    /// An integer representing the sequence number of this location in a series of measurements.
    var locationNumber = 0
    
    /// An integer representing the number of measurements taken at this location.
    var measurementNumber = 0
}

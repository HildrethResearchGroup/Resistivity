//
//  Protocol_Info.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation

/// The `Info` protocol defines a single method `info` that is expected to return information about the conforming type.
/// The associated type `Output` allows for flexibility in the type of information that can be returned.
protocol Info {
    // Define an associated type named `Output`. The conforming type will specify the actual type for `Output`.
    associatedtype Output
    
    /// Retrieves information about the conforming type.
    ///
    /// - Returns: An instance of the associated type `Output`, containing information about the conforming type.
    func info() -> Output
}

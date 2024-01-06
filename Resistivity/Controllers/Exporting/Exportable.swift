//
//  Exportable.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

/// The `Exportable` protocol defines a common interface for objects that can be exported.
/// It requires conforming types to provide a header and data representation suitable for export.
protocol Exportable {
    
    /// Generates a header for the exportable data.
    /// This method is expected to return an array of strings that represent the column headers or metadata.
    ///
    /// - Returns: An array of `String` representing the headers of the data to be exported.
    func header() -> [String]
    
    /// Generates the data for export.
    /// This method is expected to return an array of strings that represent the data rows.
    ///
    /// - Returns: An array of `String` representing the data to be exported.
    func data() -> [String]
}

//
//  VISAInstrumentProtocol.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/6/23.
//

import Foundation

/// A protocol defining the requirements for a VISA instrument communication.
/// VISA (Virtual Instrument Software Architecture) is a standard for configuring,
/// programming, and troubleshooting instrumentation systems comprising GPIB, VXI, PXI,
/// serial (RS232/RS485), Ethernet/LXI, and/or USB interfaces.
protocol VISAInstrumentProtocol {
    /// Initializes a new instance of a VISA instrument with the specified IP address and port.
    /// This initializer is asynchronous and may return `nil` if the instrument cannot be reached or initialized.
    /// - Parameters:
    ///   - ipAddress: The IP address of the instrument to connect to.
    ///   - port: The port number on which the instrument is listening.
    init?(ipAddress: String, port: Int) async
    
    /// Retrieves the identifier of the instrument.
    /// This function is asynchronous and may throw an error if the identifier cannot be retrieved.
    /// - Returns: A `String` representing the identifier of the instrument.
    func getIdentifier() async throws -> String
}

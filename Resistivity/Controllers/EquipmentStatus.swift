//
//  EquipmentStatus.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/23/23.
//

import Foundation

/// An enumeration representing the possible states of equipment within the Resistivity application.
///
/// - disconnected: The equipment is not connected to the application.
/// - connecting: The equipment is in the process of establishing a connection.
/// - connected: The equipment is connected and ready for use.
/// - measuring: The equipment is currently performing a measurement.
enum EquipmentStatus {
    case disconnected
    case connecting
    case connected
    case measuring
}

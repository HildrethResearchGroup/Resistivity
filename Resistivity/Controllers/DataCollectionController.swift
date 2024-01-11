//
//  DataCollectionController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation
import SwiftUI

/// `DataCollectionController` is responsible for managing the connection to and communication with a NanoVolt Meter device.
/// It stores the IP address and port for the connection, handles the creation of the meter controller, and posts notifications
/// about the equipment status changes.
class DataCollectionController: Observable {
    /// The IP address used to connect to the NanoVolt Meter, persisted in `UserDefaults`.
    var ipAddress: String? {
        get {
            return UserDefaults.standard.string(forKey: UD_ipAddressKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UD_ipAddressKey)
        }
    }
    
    /// The port number used to connect to the NanoVolt Meter, persisted in `UserDefaults`.
    var port: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UD_portKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UD_portKey)
        }
    }
    
    /// The minimum delay between commands sent to the NanoVolt Meter to prevent overloading the device with requests.
    static var minimumDelay: UInt32 = 2_000_000
    
    /// An optional `NanoVoltMeterController` instance that represents the connected NanoVolt Meter.
    /// When set, it updates the `equipmentStatus` based on whether the meter is nil or not.
    var ohmMeter: NanoVoltMeterController? = nil {
        didSet {
            if ohmMeter == nil {
                equipmentStatus = .disconnected
            } else {
                equipmentStatus = .connected
            }
        }
    }
    
    /// The mode in which the data is returned from the NanoVolt Meter.
    var returnMode: ReturnMode = .identifier
    
    /// The published property representing the current status of the equipment.
    /// When set, it posts a notification to inform observers of the status change.
    @Published var equipmentStatus: EquipmentStatus = .disconnected {
        didSet {
            NotificationCenter.default.post(name: .nanovoltmeterStatusDidChange, object: equipmentStatus)
        }
    }
    
    /// Asynchronously creates an instance of `NanoVoltMeterController` using the stored IP address and port.
    /// It sets the `equipmentStatus` accordingly and fetches initial information from the meter.
    /// - Throws: `DataCollectionError` if the IP address or port is not set, or if the meter cannot be created.
    func createOhmMeter() async throws {
        guard let localIPAddress = ipAddress else { throw DataCollectionError.noIPAddress }
        guard let localPort = port else { throw DataCollectionError.noPort }
        
        equipmentStatus = .connecting
        
        guard let meter = await NanoVoltMeterController(ipAddress: localIPAddress, port: localPort) else {
            equipmentStatus = .disconnected
            
            throw DataCollectionError.couldNotCreateOhmMeter
        }
        
        ohmMeter = meter
        equipmentStatus = .connected
        
        let _ =  try await self.getInformation()
    }
    
    /// Enumeration defining the possible errors that can occur during data collection.
    enum DataCollectionError: Error {
        case couldNotCreateOhmMeter // Indicates failure to create an Ohm meter instance.
        case ohmMeterNotConnected // Indicates that the Ohm meter is not connected.
        case noIPAddress // Indicates that no IP address is available for the Ohm meter.
        case noPort // Indicates that no port number is available for the Ohm meter.
        case couldNotMeasureResistance // Indicates a failure in measuring resistance.
        case couldNotGetInstrumentInformation // Indicates failure to retrieve instrument information.
    }
    
    /// Initializes a new `DataCollectionController` instance and sets default initial values for the instrument connection.
    init() {
        setDefaultInitalInstrumentConnectionValues()
    }
    
    /// Sets initial IP Address and Port for communicating with the NanoVolt Meter.
    /// These initial values should match the values set on the GPIB to TCP/IP adapter.
    private func setDefaultInitalInstrumentConnectionValues() {
        let storedIPAddress = UserDefaults.standard.string(forKey: UD_ipAddressKey)
        
        if storedIPAddress == nil {
            ipAddress = defaultInitialIPAddress
        }
        
        let storedPort = UserDefaults.standard.integer(forKey: UD_portKey)
        
        if storedPort == 0 {
            port = defaultInitialPort
        }
    }
}

// MARK: - User Default Keys
extension DataCollectionController {
    /// The key used to store and retrieve the IP address from `UserDefaults`.
    private var UD_ipAddressKey: String {
        return "ipAddress"
    }
    
    /// The key used to store and retrieve the port number from `UserDefaults`.
    private var UD_portKey: String {
        return "port"
    }
    
    /// The default initial IP address for the NanoVolt Meter.
    private var defaultInitialIPAddress: String {
        return "169.254.1.103"
    }
    
    /// The default initial port number for the NanoVolt Meter.
    private var defaultInitialPort: Int {
        return 1234
    }
}

// MARK: - Notification.Name Keys
extension Notification.Name {
    /// Notification name for when the status of the NanoVolt Meter changes.
    static let nanovoltmeterStatusDidChange = Notification.Name("nanovoltmeterStatusDidChange")
}

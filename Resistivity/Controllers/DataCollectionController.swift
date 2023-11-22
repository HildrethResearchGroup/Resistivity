//
//  DataCollectionController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation
import SwiftUI

class DataCollectionController {
    var ipAddress: String? {
        get {
            return UserDefaults.standard.string(forKey: UD_ipAddressKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UD_ipAddressKey)
        }
    }
    
    var port: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UD_portKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UD_portKey)
        }
    }
    
    
    private var ohmMeter: NanoVoltMeterController? = nil {
        didSet {
            if ohmMeter == nil {
                equipmentStatus = .disconnected
            } else {
                equipmentStatus = .connected
            }
        }
    }
    
    
    @Published var equipmentStatus: EquipmentStatus = .disconnected
    
    func createOhmMeter() throws {
        guard let localIPAddress = ipAddress else { throw DataCollectionError.noIPAddress }
        guard let localPort = port else { throw DataCollectionError.noPort }
        
        Task {
            guard let meter = await NanoVoltMeterController(ipAddress: localIPAddress, port: localPort) else {
                equipmentStatus = .disconnected
                throw DataCollectionError.couldNotCreateOhmMeter
            }
            
            ohmMeter = meter
            equipmentStatus = .connected
        }
    }
    
    enum DataCollectionError: Error {
        case couldNotCreateOhmMeter
        case ohmMeterNotConnected
        case noIPAddress
        case noPort
        case couldNotMeasureResistance
        case couldNotGetInstrumentInformation
    }
    
    
    enum EquipmentStatus {
        case disconnected
        case connected
        case measuring
    }
    
    
    
    init() {
        setDefaultInitalInstrumentConnectionValues()
    }
    
    /// Private function that sets initial IP Address and Port for communicating with the NanoVolt Meter.  These initial values should match the values set on the GPIB to TCP/IP adapter.
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

// MARK:
extension DataCollectionController {
    func measureResistance() async throws -> Double {
        
        /*
         if connectionStatus == .disconnected {
             throw DataCollectionError.ohmMeterNotConnected
         }
         */
        
        
        guard let resistance = try await ohmMeter?.getResistance() else {
            throw DataCollectionError.couldNotMeasureResistance
        }
        
        return resistance
    }
    
    func getInformation() async throws -> String {
        
        /*
         if connectionStatus == .disconnected {
             throw DataCollectionError.ohmMeterNotConnected
         }
         */
        
        
        guard let info = try await ohmMeter?.getIdentifier() else {
            //throw DataCollectionError.couldNotGetInstrumentInformation
            return "Could Not Get Identifier"
        }
        
        return info
    }
}


// MARK: - User Default Keys
extension DataCollectionController {
    
    private var  UD_ipAddressKey: String {
        get { return "ipAddress" }
    }
    
    private var UD_portKey: String {
        get { return "port"}
    }
    
    
    private var defaultInitialIPAddress: String {
        //return "169.254.10.1"
        return "169.254.1.103"
    }
    private var defaultInitialPort: Int {
        return 1234
    }
}






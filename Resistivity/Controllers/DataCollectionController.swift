//
//  DataCollectionController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation
import SwiftUI


class DataCollectionController: Observable {
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
    
    static var minimumDelay: UInt32 = 2_000_000
    
    private var ohmMeter: NanoVoltMeterController? = nil {
        didSet {
            if ohmMeter == nil {
                equipmentStatus = .disconnected
            } else {
                equipmentStatus = .connected
            }
        }
    }
    
    var returnMode: ReturnMode = .identifier
    
    
    @Published var equipmentStatus: EquipmentStatus = .disconnected {
        didSet {
            NotificationCenter.default.post(name: .nanovoltmeterStatusDidChange, object: equipmentStatus)
        }
    }
    
    func createOhmMeter() throws {
        guard let localIPAddress = ipAddress else { throw DataCollectionError.noIPAddress }
        guard let localPort = port else { throw DataCollectionError.noPort }
        
        equipmentStatus = .connecting
        
        
        Task {
            guard let meter = await NanoVoltMeterController(ipAddress: localIPAddress, port: localPort) else {
                equipmentStatus = .disconnected
                throw DataCollectionError.couldNotCreateOhmMeter
            }
            
            ohmMeter = meter
            // equipmentStatus = .connected
            
            if ohmMeter != nil {
                equipmentStatus = .connected
            }
            
            if let info =  try? await self.getInformation() {
                print(info)
            } else {
                print("Could not get info at end of createOhmMeter")
            }

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

// MARK: - Data Collection
extension DataCollectionController {
    func measureResistance() async throws -> Double {
        
        if self.returnMode != .resistivity {
            self.returnMode = .resistivity
            
            await self.flushOldData(for: .resistivity)
        }
        
        let storedEquipmentStatus = equipmentStatus
        
         if equipmentStatus == .disconnected {
             throw DataCollectionError.ohmMeterNotConnected
         }
         
        equipmentStatus = .measuring
        
        guard let resistance = try await ohmMeter?.getResistance() else {
            equipmentStatus = storedEquipmentStatus
            throw DataCollectionError.couldNotMeasureResistance
        }
        
        equipmentStatus = storedEquipmentStatus
        return resistance
    }
    
    func measureResistance(times numberOfMeasurements: Int, withPeriod seconds: Double) async throws -> [Double] {
        
        // Create an array to store the measurements
        var measurements: [Double] = []
        
        // Check to make sure inputs are valid
        if numberOfMeasurements < 1 {
            return measurements
        }
        
        if seconds.sign == .minus {
            return measurements
        }
        
        for _ in 1...numberOfMeasurements {
            let nextResistance = try await self.measureResistance()
            
            usleep(NanoVoltMeterController.minimumDelay)
            
            measurements.append(nextResistance)
        }
        
        
        return measurements
    }
    
    func getInformation() async throws -> String {
        
        if self.returnMode != .identifier {
            self.returnMode = .identifier
            await self.flushOldData(for: .identifier)
        }
        
         if equipmentStatus == .disconnected {
             throw DataCollectionError.ohmMeterNotConnected
         }
         
        guard let info = try await ohmMeter?.getIdentifier() else {
            //throw DataCollectionError.couldNotGetInstrumentInformation
            return "Could Not Get Identifier"
        }
        
        return info
    }
    
    
    // The instrument often sends back old data − to make sure that the old data is at least compatible with the new data, query some new data until new data will be returned
    func flushOldData(for returnMode: ReturnMode) async {
        switch returnMode {
        case .identifier:
            for _ in 0..<3 {
                _ = try? await self.getInformation()
                usleep(NanoVoltMeterController.minimumDelay)
            }
        case .resistivity:
            for _ in 0..<3 {
                _ = try? await self.measureResistance()
                usleep(NanoVoltMeterController.minimumDelay)
            }
        }
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


// MARK: - Notification.Name Keys
extension Notification.Name {
    static let nanovoltmeterStatusDidChange = Notification.Name("nanovoltmeterStatusDidChange")
}


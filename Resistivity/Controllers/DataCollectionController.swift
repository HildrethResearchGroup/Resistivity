//
//  DataCollectionController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation
import SwiftUI

class DataCollectionController {
    private var ipAddress: String? {
        get {
            return UserDefaults.standard.string(forKey: "ipAddress")
        }
    }
    private var port: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "port")
        }
    }
    
    
    private var ohmMeter: NanoVoltMeterController? = nil {
        didSet {
            if ohmMeter == nil {
                connectionStatus = .disconnected
            } else {
                connectionStatus = .connected
            }
        }
    }
    
    
    @Published var connectionStatus: ConnectionStatus = .disconnected
    
    func createOhmMeter() throws {
        guard let localIPAddress = ipAddress else { throw DataCollectionError.noIPAddress }
        guard let localPort = port else { throw DataCollectionError.noPort }
        
        Task {
            guard let meter = await NanoVoltMeterController(ipAddress: localIPAddress, port: localPort) else {
                connectionStatus = .disconnected
                throw DataCollectionError.couldNotCreateOhmMeter
            }
            
            ohmMeter = meter
            connectionStatus = .connected
        }
    }
    
    enum DataCollectionError: Error {
        case couldNotCreateOhmMeter
        case ohmMeterNotConnected
        case noIPAddress
        case noPort
    }
    
    enum ConnectionStatus {
        case disconnected
        case connected
    }
    
    
}






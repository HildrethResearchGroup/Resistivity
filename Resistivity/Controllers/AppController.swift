//
//  AppController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/21/23.
//

import Foundation

@MainActor
class AppController: ObservableObject {
    @Published var collectionController: DataCollectionController
    @Published var dataModel: DataModel
    
    init() {
        collectionController = DataCollectionController()
        dataModel = DataModel()
        registerForNotifications()
    }
    
    @Published var lastMeasurement: Double = 0.0
    
    @Published var information: String = "Nothing Yet"
    
    @Published var nanoVoltMeterStatus: EquipmentStatus = .disconnected
    
    func measureResistance() {
        Task {
            do {
                let resistance = try await collectionController.measureResistance()
                lastMeasurement = resistance
                dataModel.addNewMeasurement(withValue: lastMeasurement)
            } catch {
                print(error)
            }
        }
    }
    
    func getInformation() {
        Task {
            do {
                let info = try await collectionController.getInformation()
                information = info
            } catch {
                print(error)
            }
        }
    }
}


extension AppController {
    func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .nanovoltmeterStatusDidChange, object: nil, queue: nil, using: updateNanovoltMeterStatus)
    }
    
    func updateNanovoltMeterStatus(_ notification: Notification) {
        
        Task.detached {@MainActor in
            guard let status = notification.object as? EquipmentStatus else {return}
            
            self.nanoVoltMeterStatus = status
        }
        
    }
}

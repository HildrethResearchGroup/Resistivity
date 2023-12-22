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
    
    
    @Published var resistivitySettings = ResistivityMeasurementSettings()
    @Published var lineResistanceSettings = LineResistanceSettings()
    
    @Published var sampleSettings = SampleSettings()
    @Published var locationSettings = LocationSettings()
    
    var globalMeasurementNumber = 1
    
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
                
                
                dataModel.addNewMeasurement(withValue: lastMeasurement, withSampleInfo: sampleSettings.info(), locationInfo: locationSettings.info(), globalMeasurementNumber: globalMeasurementNumber)
                
                globalMeasurementNumber += 1
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
    
    private func registerForNotifications() {
        
        NotificationCenter.default.addObserver(forName: .nanovoltmeterStatusDidChange, object: nil, queue: .current, using: updateNanovoltMeterStatus)
        
        
    }
    
    
    
    /// Updates Nanovoltmeter Status whenever the `nanovoltmeterStatusDidChange` notification is received.
    ///
    /// This function is marked as nonisolated becuase NotificationCenter's `addObserver` function requires an `@Sendable` clsoure.  Without making this function as `nonisolated`, the addObserver function results in a warning: "Converting function value of type '@MainActor (Notification) -> ()' to '@Sendable (Notification) -> Void' loses global actor 'MainActor'"
    ///
    /// - Parameter notification: nanovoltmeterStatusDidChange Notification
    nonisolated private func updateNanovoltMeterStatus(_ notification: Notification) {
        
        // Thie status must be updated within the updatedNanovoltmeterStatus closure.  However, updating the AppController's nanoVoltMeterStatus must be done on the MainActor's thread since AppController is marked as @MainActor
        guard let status = notification.object as? EquipmentStatus else {return}
        Task {
            await MainActor.run {
                self.nanoVoltMeterStatus = status
            }
        }
        
        
    }
}

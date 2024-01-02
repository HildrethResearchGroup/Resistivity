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
    @Published var dataViewModel: DataViewModel
    
    @Published var measurementSettings = MeasurementSettings()
    @Published var resistivitySettings = ResistivityMeasurementSettings()
    @Published var lineResistanceSettings = LineResistanceSettings()
    
    @Published var sampleSettings = SampleSettings()
    @Published var locationSettings = LocationSettings()
    
    @Published var nanoVoltMeterStatus: EquipmentStatus = .disconnected
    
    
    var globalMeasurementNumber = 1
    
    init() {
        collectionController = DataCollectionController()
        
        let localDataModel = DataModel(withInitialData: true)
        dataModel = localDataModel
        dataViewModel = DataViewModel(dataModel: localDataModel)
        registerForNotifications()
    }
    
    
    
    
    @Published var lastMeasurement: Double = 0.0
    
    @Published var information: String = "Nothing Yet"
    
    
    
    func measureResistance() {
        Task {
            do {
                
                let numberOfMeasurements = measurementSettings.numberOfMeasurements
                let timeBetweenMeasurements = measurementSettings.timeBetweenMeasurements
                
                // Update the nanovoltmeter status to measuring
                // First, record the current status
                let lastNanoVoltMeterStatus = nanoVoltMeterStatus
                
                nanoVoltMeterStatus = .measuring
                
                // Measure the resinstance
                let resistances = try await collectionController.measureResistance(times: numberOfMeasurements, withPeriod: timeBetweenMeasurements)
                
                // Update the value of the last resistnace measured
                lastMeasurement = resistances.last ?? 0.0
                
                
                // Update the data model with the new resistances
                for nextMeasurement in resistances {
                    dataModel.addNewMeasurement(withValue: nextMeasurement,
                                                withSampleInfo: sampleSettings.info(),
                                                locationInfo: locationSettings.info(),
                                                resistivityInfo: resistivitySettings.info(),
                                                lineResistanceInfo: lineResistanceSettings.info(),
                                                globalMeasurementNumber: globalMeasurementNumber)
                    
                    globalMeasurementNumber += 1
                }
                
                // Reset the nanovoltmeter status
                nanoVoltMeterStatus = lastNanoVoltMeterStatus
               
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

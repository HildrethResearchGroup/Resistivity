//
//  AppController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/21/23.
//

import Foundation
import AppKit

/// `AppController` is the main controller class that orchestrates the flow of data and events in the application.
/// It holds references to various controllers and settings, and manages the application state.
@MainActor
class AppController: ObservableObject {
    @Published var collectionController: DataCollectionController
    @Published var dataModel: DataModel
    @Published var dataViewModel: DataViewModel
    @Published var selectionManager: SelectionManager
    
    @Published var measurementSettings = MeasurementSettings()
    @Published var resistivitySettings = ResistivityMeasurementSettings()
    @Published var lineResistanceSettings = LineResistanceSettings()
    
    @Published var sampleSettings = SampleSettings()
    @Published var locationSettings = LocationSettings()
    
    @Published var nanoVoltMeterStatus: EquipmentStatus = .disconnected
    
    @Published var information: String = "Not Connected Nanovoltmeter"
    
    var globalMeasurementNumber = 1
    
    /// Initializes a new instance of `AppController`.
    /// It sets up the data collection controller, data model, data view model, and selection manager.
    /// It also registers for notifications to update the nanovoltmeter status.
    init() {
        collectionController = DataCollectionController()
        #if DEBUG
        let localDataModel = DataModel(withInitialData: true)
        #else
        let localDataModel = DataModel()
        #endif
        
        dataModel = localDataModel
        
        let localDataViewModel = DataViewModel(dataModel: localDataModel)
        
        dataViewModel = localDataViewModel
        selectionManager = SelectionManager(dataViewModel: DataViewModel(dataModel: localDataModel))
        
        registerForNotifications()
    }
}


// MARK: - Notifications
extension AppController {
    
    /// Registers the `AppController` to listen for notifications that indicate a change in the nanovoltmeter status.
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .nanovoltmeterStatusDidChange, object: nil, queue: .current, using: updateNanovoltMeterStatus)
    }
    
    
    /// Updates the nanovoltmeter status whenever the `nanovoltmeterStatusDidChange` notification is received.
    /// This method is marked as `nonisolated` because NotificationCenter's `addObserver` function requires an `@Sendable` closure.
    /// Without marking this function as `nonisolated`, the addObserver function results in a warning about losing the global actor 'MainActor'.
    ///
    /// - Parameter notification: The notification containing the new nanovoltmeter status.
    nonisolated private func updateNanovoltMeterStatus(_ notification: Notification) {
        
        // The status must be updated within the updateNanovoltmeterStatus closure.
        // However, updating the AppController's nanoVoltMeterStatus must be done on the MainActor's thread since AppController is marked as @MainActor.
        guard let status = notification.object as? EquipmentStatus else { return }
        Task {
            await MainActor.run {
                self.nanoVoltMeterStatus = status
            }
        }
    }
}

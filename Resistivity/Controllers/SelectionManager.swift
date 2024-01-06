//
//  SelectionManager.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/4/24.
//

import Foundation
import AppKit

/// `SelectionManager` is responsible for managing the selection state of measurements within the application.
/// It interacts with the `DataModel` to filter and manipulate selected measurements.
@MainActor
class SelectionManager: ObservableObject {
    private var dataModel: DataModel
    @Published var selection_measurements: Set<UUID> = []
    
    /// Initializes a new SelectionManager with a given DataModel.
    /// - Parameter dataModel: The `DataModel` instance that contains the measurements.
    init(dataModel: DataModel) {
        self.dataModel = dataModel
    }
    
    /// Retrieves the currently selected measurements from the data model.
    /// - Returns: An array of `Measurement` objects that are currently selected.
    func selectedMeasurements() -> [Measurement] {
        let localMeasurements = dataModel.flattendMeasurements
        
        let copySelectionIDs = selection_measurements
        let copyMeasurements = localMeasurements.filter({ nextMeasurement in
            copySelectionIDs.contains(nextMeasurement.id)
        })
        
        return copyMeasurements
    }
    
    /// Copies the selected measurements to the system clipboard in CSV format.
    func postCopyMeasurements() {
        let copyMeasurements = selectedMeasurements()
        
        let em = ExportManager()
        
        let exportCSVString = em.csv(for: copyMeasurements)
        
        let pasteboard_general = NSPasteboard(name: .general)
        
        pasteboard_general.clearContents()
        pasteboard_general.setString(exportCSVString, forType: .string)
        
        // This line is commented out, but it suggests that there was an intention to post a notification
        // when the measurements are copied. This could be used to notify other parts of the app.
        // NotificationCenter.default.post(name: .copyMeasurements, object: copyMeasurements)
    }
    
    /// Deletes the selected measurements from the data model.
    func deleteSelectedMeasurements() {
        dataModel.deleteMeasurements(selectedMeasurements())
    }
    
    /// Clears the current selection of measurements.
    func clearMeasurementsSelection() {
        selection_measurements.removeAll()
    }
}

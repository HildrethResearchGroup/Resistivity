//
//  SelectionManager.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/4/24.
//

import Foundation
import AppKit

@MainActor
class SelectionManager: ObservableObject {
    private var dataModel: DataModel
    @Published var selection_measurements: Set<UUID> = []
    
    init(dataModel: DataModel) {
        self.dataModel = dataModel
    }
    
    func selectedMeasurements() -> [Measurement] {
        let localMeasurements = dataModel.flattendMeasurements
        
        let copySelectionIDs = selection_measurements
        let copyMeasurements = localMeasurements.filter({ nextMeasurement in
            copySelectionIDs.contains(nextMeasurement.id)
        })
        
        return copyMeasurements
    }
    
    func postCopyMeasurements() {
        let copyMeasurements = selectedMeasurements()
        
        let em = ExportManager()
        
        let exportCSVString = em.csv(for: copyMeasurements)
        
        let pasteboard_general = NSPasteboard(name: .general)
        
        pasteboard_general.clearContents()
        pasteboard_general.setString(exportCSVString, forType: .string)
        
        //NotificationCenter.default.post(name: .copyMeasurements, object: copyMeasurements)
    }
    
    func deleteSelectedMeasurements() {
        dataModel.deleteMeasurements(selectedMeasurements())
    }
    
    func clearMeasurementsSelection() {
        selection_measurements.removeAll()
    }
}

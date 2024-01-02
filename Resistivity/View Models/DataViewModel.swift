//
//  DataViewModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

@MainActor
class DataViewModel: ObservableObject {
    @Published var dataModel: DataModel
    
    @Published var search: String = ""
    @Published var order: [KeyPathComparator<Measurement>] {
        didSet {
            updateSortedMeasurements()
        }
    }
    
    private var flattenedMeasurements: [Measurement] = [] {
        didSet {
            updateFilterMeasurements()
        }
    }
    
    private var filteredMeasurements: [Measurement] = [] {
        didSet {
            updateSortedMeasurements()
        }
    }
    
    @Published var measurements: [Measurement] = []
    
    
    // MARK: - Statistics Properties
    var resistanceStatistics = Statistics<Measurement>(keyPath: \.resistance, name: "Resistance", units: "Ω")
    var resistivityStatistics = Statistics<Measurement>(keyPath: \.resistivity, name: "Resistivity", units: "Ω-m")
    
    
    init(dataModel: DataModel) {
        self.dataModel = dataModel
        self.order = [
            .init(\.globalMeasurementNumber, order: SortOrder.forward),
            .init(\.resistance, order: SortOrder.forward),
            .init(\.sampleInfo.name, order: SortOrder.forward),
            .init(\.locationInfo.name, order: SortOrder.forward),
            .init(\.sampleID, order: SortOrder.forward),
        ]
        self.updateFlattenedMeasurement()
    }
}

// MARK: - Updating Measurements
extension DataViewModel {
    /// Updates the array of Flattened Measurements whenever a new measurement is created.  This function is triggered when the `newMeasurementAdded` notification is received.
    ///
    /// This function is marked as nonisolated becuase NotificationCenter's `addObserver` function requires an `@Sendable` clsoure.  Without making this function as `nonisolated`, the addObserver function results in a warning: "Converting function value of type '@MainActor (Notification) -> ()' to '@Sendable (Notification) -> Void' loses global actor 'MainActor'"
    ///
    /// - Parameter notification: newMeasurementAdded notification
    nonisolated private func updateFlattenedMeasurement(_ notification: Notification) {
        self.updateFlattenedMeasurement()
        
    }
    
    nonisolated private func updateFlattenedMeasurement() {
        // Thie status must be updated within the updateFlattenedMeasurement closure.  However, updating the DataModel's flattendMeasurements must be done on the MainActor's thread since DataModel is marked as @MainActor
        
        Task {
            await MainActor.run {
                var measurements: [Measurement] = []
                
                for nextSample in dataModel.samples {
                    measurements.append(contentsOf: nextSample.flattendMeasurements)
                }
                
                self.flattenedMeasurements =  measurements
                self.updateStatistics()
            }
        }
    }
    
    
    private func updateFilterMeasurements() {
        self.filteredMeasurements = filterMeasurements(flattenedMeasurements, withString: search)
    }
    
    
    func filterMeasurements(_ measurementsIn: [Measurement], withString filterString: String) -> [Measurement] {
        return measurementsIn.filter({$0.contains(information: filterString)})
    }
    
    
    func updateSortedMeasurements() {
        self.measurements = self.filteredMeasurements.sorted(using: order)
    }
}


// MARK: - Statistics
extension DataViewModel {
    private func updateStatistics() {
        resistanceStatistics.update(with: flattenedMeasurements)
        resistivityStatistics.update(with: flattenedMeasurements)
    }
}



// MARK: - Register for Notifications
extension DataViewModel {
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .newMeasurementAdded, object: nil, queue: nil, using: updateFlattenedMeasurement(_:))
    }
}

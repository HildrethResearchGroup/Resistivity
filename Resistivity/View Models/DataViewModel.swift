//
//  DataViewModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/1/24.
//

import Foundation

/// `DataViewModel` is responsible for managing and preparing the data for presentation in the UI.
/// It observes changes to the underlying `DataModel` and provides sorted, filtered, and statistical views of the measurements.
@MainActor
class DataViewModel: ObservableObject {
    @Published var dataModel: DataModel
    
    /// The search string used for filtering measurements.
    @Published var search: String = "" {
        didSet {
            self.updateFlattenedMeasurement()
        }
    }
    
    /// The array of comparators used for sorting measurements. When the order is changed, the sorted measurements are updated.
    @Published var order: [KeyPathComparator<Measurement>] {
        didSet {
            updateSortedMeasurements()
        }
    }
    
    /// A flattened array of all measurements. When this array is updated, the filtered measurements are also updated.
    private var flattenedMeasurements: [Measurement] = [] {
        didSet {
            updateFilterMeasurements()
        }
    }
    
    /// An array of measurements filtered based on the search string. When this array is updated, the sorted measurements are also updated.
    private var filteredMeasurements: [Measurement] = [] {
        didSet {
            updateSortedMeasurements()
        }
    }
    
    /// The final array of measurements that are presented in the UI, after applying both filtering and sorting.
    @Published var measurements: [Measurement] = []
    
    
    var filteredSamples: [Sample] {
        if search.count == 0 {
            return dataModel.samples
        } else {
            var localSamples: [Sample] = []
            
            for nextSample in dataModel.samples {
                if nextSample.flattendMeasurements.filter({$0.contains(information: search)}).count != 0 {
                    localSamples.append(nextSample)
                }
            }
            return localSamples
        }
    }
    
    
    // MARK: - Statistics Properties
    
    /// Statistics for resistance measurements, including the name and units for display purposes.
    var resistanceStatistics = Statistics<Measurement>(keyPath: \.resistance, name: "Resistance", units: "Ω")
    
    /// Statistics for resistivity measurements, including the name and units for display purposes.
    var resistivityStatistics = Statistics<Measurement>(keyPath: \.resistivity, name: "Resistivity", units: "Ω-m")
    
    var lineResistanceStatistics = Statistics<Measurement>(keyPath: \.lineResistance, name: "Resistivity", units: "Ω/m")
    
    /// Initializes a new `DataViewModel` with a given `DataModel`.
    /// - Parameter dataModel: The `DataModel` instance to be managed by this view model.
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
        self.registerForNotifications()
    }
}

// MARK: - Updating Measurements
extension DataViewModel {
    /// Updates the array of flattened measurements whenever a new measurement is created.
    /// This function is triggered when the `newMeasurementAdded` notification is received.
    /// It is marked as `nonisolated` because NotificationCenter's `addObserver` function requires an `@Sendable` closure.
    /// Without marking this function as `nonisolated`, the addObserver function results in a warning.
    /// - Parameter notification: The `newMeasurementAdded` notification.
    nonisolated private func updateFlattenedMeasurement(_ notification: Notification) {
        self.updateFlattenedMeasurement()
    }
    
    /// Updates the flattened measurements by combining all measurements from each sample in the data model.
    /// This function must be called on the main actor's thread since `DataModel` is marked with `@MainActor`.
    nonisolated private func updateFlattenedMeasurement() {
        Task {
            await MainActor.run {
                var localMeasurements: [Measurement] = []
                
                for nextSample in dataModel.samples {
                    localMeasurements.append(contentsOf: nextSample.flattendMeasurements)
                }
                
                self.flattenedMeasurements = localMeasurements
                self.updateStatistics()
            }
        }
    }
    
    /// Updates the filtered measurements based on the current search string.
    private func updateFilterMeasurements() {
        self.filteredMeasurements = filterMeasurements(flattenedMeasurements, withString: search)
    }
    
    /// Filters the given array of measurements based on the provided filter string.
    /// - Parameters:
    ///   - measurementsIn: The array of measurements to filter.
    ///   - filterString: The string to use for filtering.
    /// - Returns: An array of measurements that match the filter string.
    func filterMeasurements(_ measurementsIn: [Measurement], withString filterString: String) -> [Measurement] {
        if filterString.count != 0 {
            return measurementsIn.filter({$0.contains(information: filterString)})
        } else {
            return measurementsIn
        }
    }
    
    /// Updates the sorted measurements based on the current order and filtered measurements.
    func updateSortedMeasurements() {
        self.measurements = self.filteredMeasurements.sorted(using: order)
    }
}


// MARK: - Statistics
extension DataViewModel {
    /// Updates the statistics for resistance and resistivity based on the current flattened measurements.
    private func updateStatistics() {
        resistanceStatistics.update(with: flattenedMeasurements)
        resistivityStatistics.update(with: flattenedMeasurements)
        lineResistanceStatistics.update(with: flattenedMeasurements)
    }
}



// MARK: - Register for Notifications
extension DataViewModel {
    /// Registers the view model to listen for notifications indicating that a new measurement has been added.
    /// When such a notification is received, the flattened measurements are updated.
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .newMeasurementAdded, object: nil, queue: .main, using: updateFlattenedMeasurement(_:))
    }
}

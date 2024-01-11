//
//  DataModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/4/23.
//

import Foundation

/// `DataModel` is the main model class for the Resistivity app, responsible for managing the data related to samples and measurements.
/// It conforms to `ObservableObject` to allow SwiftUI views to react to changes in the data.
@MainActor
class DataModel: ObservableObject {
    /// An array of `Sample` objects representing the collection of samples in the app.
    @Published var samples: [Sample] = []
    
    /// A counter for the number of measurements taken, used to assign a unique number to each measurement.
    @Published var measurementNumber: Int = 0
    
    /// An array of `KeyPathComparator` objects that define the sorting order for measurements.
    /// When the order is changed, the flattened measurements are sorted accordingly.
    @Published var order: [KeyPathComparator<Measurement>] = [
        .init(\.globalMeasurementNumber, order: SortOrder.forward),
        .init(\.resistance, order: SortOrder.forward),
        .init(\.sampleInfo.name, order: SortOrder.forward),
        .init(\.locationInfo.name, order: SortOrder.forward),
        .init(\.sampleID, order: SortOrder.forward),
    ] {
        didSet {
            flattendMeasurements = flattendMeasurements.sorted(using: order)
        }
    }
    
    /// A string used for searching within measurements.
    @Published var search: String = ""
    
    // MARK: - Measurement Properties
    /// An array of `Measurement` objects representing all measurements from all samples, flattened for easier access and sorting.
    @Published var flattendMeasurements: [Measurement] = []
    
    // MARK: - Convenience Properties
    /// A computed property that returns the most recently added `Sample` object, if any.
    var currentSample: Sample? { return samples.last }
    
    // MARK: - Initialization
    /// Initializes a new instance of `DataModel` and registers for notifications.
    init() {
        self.registerForNotifications()
    }
    
    /// A convenience initializer that can generate initial data for the app.
    /// - Parameter shouldGenerateInitialData: A boolean indicating whether to generate initial data.
    convenience init(withInitialData shouldGenerateInitialData: Bool = true) {
        self.init()
        
        if shouldGenerateInitialData {
            self.generateInitialData()
        }
    }
}

// MARK: - Register for Notifications
extension DataModel {
    /// Registers the `DataModel` instance to listen for notifications indicating that a new measurement has been added.
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .newMeasurementAdded, object: nil, queue: nil, using: updateFlattenedMeasurement(_:))
    }
    
    /// Updates the array of flattened measurements whenever a new measurement is created. This function is triggered when the `newMeasurementAdded` notification is received.
    /// This function is marked as nonisolated because NotificationCenter's `addObserver` function requires an `@Sendable` closure. Without marking this function as `nonisolated`, the addObserver function results in a warning: "Converting function value of type '@MainActor (Notification) -> ()' to '@Sendable (Notification) -> Void' loses global actor 'MainActor'"
    /// - Parameter notification: The `newMeasurementAdded` notification containing information about the new measurement.
    nonisolated private func updateFlattenedMeasurement(_ notification: Notification) {
        // The status must be updated within the updateFlattenedMeasurement closure. However, updating the DataModel's flattenedMeasurements must be done on the MainActor's thread since DataModel is marked as @MainActor.
        
        Task {
            await MainActor.run {
                var measurements: [Measurement] = []
                
                for nextSample in samples {
                    measurements.append(contentsOf: nextSample.flattendMeasurements)
                }
                
                flattendMeasurements = measurements
            }
        }
    }
}

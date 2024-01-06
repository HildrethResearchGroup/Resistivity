//
//  MeasurementsViewModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation


class Sample {
    var id = UUID()
    
    var info: SampleInfo
    
    @Published var locations: [Location] = []
    
    @Published var resistanceStatistics = Statistics<Measurement>(keyPath: \.resistance, name: "Resistance", units: "Ω")
    @Published var resistivityStatistics = Statistics<Measurement>(keyPath: \.resistivity, name: "Resistivity", units: "Ω-m")
    @Published var lineResistanceStatistics = Statistics<Measurement>(keyPath: \.lineResistance, name: "Resistivity", units: "Ω-m")
    
    // MARK: - Convienence Getters
    var flattendMeasurements: [Measurement] {
        get {
            return locations.flatMap { $0.measurements }
        }
    }
    
    var currentLocation: Location? {
        get {
            return locations.last
        }
    }
    
    var numberOfMeasurementsInSample: Int {
        return flattendMeasurements.count
    }
    
    
    
    // MARK: - Initializers
    init(_ sampleInfo: SampleInfo) {
        self.info = sampleInfo
        self.registerForNotifications()
    }
    
    
    private func updateStatistics() {
        let localMeasurements = flattendMeasurements
        resistanceStatistics.update(with: localMeasurements)
        resistivityStatistics.update(with: localMeasurements)
    }
    
}

// MARK: - Common Conformances
extension Sample: Identifiable, Equatable {
    static func == (lhs: Sample, rhs: Sample) -> Bool {
        return lhs.id == rhs.id
    }
}


// MARK: - Add New Measurements
extension Sample {
    
    
    func addMeasurement(_ resistanceIn: Double, globalMeasurementNumber: Int, locationInfo: LocationInfo, resistivityInfo: ResistivityMeasurementInfo, lineResistanceInfo: LineResistanceInfo) {
        
        // Update the number of measurements in the sample
        info.measurementNumber = self.numberOfMeasurementsInSample + 1
        
        
        //
        if self.isANewLocationNeeded(withInfo: locationInfo) {
            createNewLocation(withInfo: locationInfo)
        }
        
        guard let location = currentLocation else {
            print("Error, there should be location available by now")
            return
        }
        
        
        location.addMeasurement(withResistance: resistanceIn,
                                sampleInfo: info,
                                resistivityInfo: resistivityInfo,
                                lineResistanceInfo: lineResistanceInfo,
                                globalMeasurementNumber: globalMeasurementNumber)
        
    }
    
    
    
    // MARK: - Location Management
    private func isANewLocationNeeded(withInfo locationInfo: LocationInfo) -> Bool {
        guard let location = currentLocation else {
            return true
        }
        
        if location.info.name != locationInfo.name {
            return true
        } else {
            return false
        }
    }
    
    
    private func createNewLocation(withInfo locationInfo: LocationInfo) {
        
        let newLocationNumber = locations.count + 1
        
        var localLocationInfo = locationInfo
        localLocationInfo.locationNumber = newLocationNumber
        
        let newLocation = Location(localLocationInfo)
        
        locations.append(newLocation)
    }
}


// MARK: - Remove Measurements
extension Sample {
    func deleteMeasurements(_ measurementsIn: [Measurement]) {
        for nextLocation in locations {
            nextLocation.removeMeasurement(measurementsIn)
        }
    }
}

// MARK: - Saving
extension Sample {
    func save() {
        print("Save")
    }
}


// MARK: - Handling Notifications
extension Sample {
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: .newMeasurementAdded, object: nil, queue: nil, using: updateStatistics(_:))
    }
    
    private func updateStatistics(_ notification: Notification) {
        guard let location = notification.object as? Location else {
            return
        }
        
        if locations.contains(location) {
            self.updateStatistics()
        }
        
    }
}

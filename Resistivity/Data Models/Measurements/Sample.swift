//
//  MeasurementsViewModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation


class Sample {
    var id = UUID()
    var name: String
    let sampleNumber: Int
    
    var locations: [Location] = []
    
    var resistanceStatistics = Statistics<Measurement>(keyPath: \.resistance, name: "Resistance", units: "Ω")
    var resistivityStatistics = Statistics<Measurement>(keyPath: \.resistivity, name: "Resistivity", units: "Ω-m")
    
    
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
    init(sampleName: String, sampleNumber sampleNumberIn: Int) {
        name = sampleName
        sampleNumber = sampleNumberIn
    }
    
    convenience init(_ sampleInfo: SampleInfo) {
        self.init(sampleName: sampleInfo.name,
                  sampleNumber: sampleInfo.sampleNumber)
    }
    
    
    
    private func updateStatistics() {
        let localMeasurements = flattendMeasurements
        resistanceStatistics.update(with: localMeasurements)
        resistivityStatistics.update(with: localMeasurements)
    }
    
}


extension Sample: Info {
    typealias Output = SampleInfo
    
    func info() -> Output {
        let info = SampleInfo(name: self.name, sampleNumber: self.sampleNumber)
        
        return info
    }
}

// MARK: - Add New Measurements
extension Sample {
    
    
    func addMeasurement(_ resistanceIn: Double, globalMeasurementNumber: Int, locationInfo: LocationInfo) {
        
        
        if self.isANewLocationNeeded(withInfo: locationInfo) {
            
            createNewLocation(withInfo: locationInfo)
        }
        
        guard let location = currentLocation else {
            print("Error, there should be location available by now")
            return
        }
        
        
        location.addMeasurement(withResistance: resistanceIn,
                                sampleInfo: self.info(),
                                locationInfo: location.info(),
                                globalMeasurementNumber: globalMeasurementNumber)
        
    }
    
    // MARK: - Location Management
    private func isANewLocationNeeded(withInfo locationInfo: LocationInfo) -> Bool {
        guard let location = currentLocation else {
            return true
        }
        
        if location.name != locationInfo.name {
            return true
        } else {
            return false
        }
    }
    
    private func createNewLocation(withInfo locationInfo: LocationInfo) {
        let newLocationNumber = locations.count + 1
        
        var locationInfo = locationInfo
        locationInfo.locationNumber = newLocationNumber
        
        let newLocation = Location(locationInfo)
        
        locations.append(newLocation)
    }
}

extension Sample {
    func save() {
        print("Save")
    }
}

extension Sample: Equatable {
    static func == (lhs: Sample, rhs: Sample) -> Bool {
        return lhs.id == rhs.id
    }
}


extension Notification.Name {
    static let newMeasurementAdded = Notification.Name("newMeasurementAdded")
}

//
//  MeasurementsViewModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation


class MeasurementSample {
    var measurements: [Measurement] = [] {
        didSet {
            updateStatistics()
            NotificationCenter.default.post(name: .newMeasurementAdded, object: nil)
        }
    }
    
    let sampleInfo: SampleInfo
    let location: LocationInfo
    let sampleNumber: Int
    var locationNumber = 1
    var localMeasurementNumber: Int = 0
    
    init(sampleNumber: Int, sampleInfo: SampleInfo, location: LocationInfo) {
        self.sampleNumber = sampleNumber
        self.sampleInfo = sampleInfo
        self.location = location
    }
    
    var resistanceStatistics = Statistics<Measurement>(keyPath: \.resistance, name: "Resistance", units: "Ω")
    var resistivityStatistics = Statistics<Measurement>(keyPath: \.resistivity, name: "Resistivity", units: "Ω-m")
    
    private func updateStatistics() {
        resistanceStatistics.update(with: measurements)
        resistivityStatistics.update(with: measurements)
    }
    
    func newLocation() {
        locationNumber += 1
        localMeasurementNumber = 0
    }
    
    func addMeasurement(_ resistanceIn: Double, withMeasurementNumber measurementNumberIn: Int) {
        localMeasurementNumber += 1
        
        let newMeasurement = Measurement(resistanceIn, withGlobal: measurementNumberIn, andSampleNumber: sampleNumber, andLocationMeasurementNumber: locationNumber, localMeasurementNumber: localMeasurementNumber, atLocation: location, withSampleInfo: sampleInfo)
        
        measurements.append(newMeasurement)
    }
}

extension MeasurementSample {
    func save() {
        print("Save")
    }
}

extension MeasurementSample: Equatable {
    static func == (lhs: MeasurementSample, rhs: MeasurementSample) -> Bool {
        return lhs.location == rhs.location && lhs.sampleInfo == rhs.sampleInfo
    }
}


extension Notification.Name {
    static let newMeasurementAdded = Notification.Name("newMeasurementAdded")
}

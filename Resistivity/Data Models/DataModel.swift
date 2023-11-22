//
//  DataModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/4/23.
//

import Foundation

@MainActor
class DataModel: ObservableObject {
    var measurementGroups: [MeasurementGroup]
    var currentSampleInfo: SampleInfo
    var currentLocationInfo: LocationInfo
    
    var currentMeasurementGroup: MeasurementGroup
    
    init() {
        let sampleInfo = SampleInfo()
        currentSampleInfo = sampleInfo
        
        let locationInfo = LocationInfo()
        currentLocationInfo = LocationInfo()
        
        currentMeasurementGroup = MeasurementGroup(sampleInfo: sampleInfo, location: locationInfo)
        
        measurementGroups = []
        measurementGroups.append(currentMeasurementGroup)
        
    }
    
    func addNewMeasurement(withValue measurement: Double) {
        
    }
    
    
    
    private func createNewMeasurementGroup() {
        currentMeasurementGroup = MeasurementGroup(sampleInfo: currentSampleInfo, location: currentLocationInfo)
        measurementGroups.append(currentMeasurementGroup)
    }
    
}

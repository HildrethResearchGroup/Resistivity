//
//  DataModel_InitialData.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/10/24.
//

import Foundation

// MARK: -  Initial Data for Testing
extension DataModel {
    /// Generates initial data for testing purposes by creating a set of measurements with random resistance values.
    /// It uses predefined sample and location information, and default resistivity and line resistance information.
    public func generateInitialData() {
        // Default resistivity measurement information used for all generated data
        let resistivityInfo = ResistivityMeasurementInfo(shouldCalculateResistivity: true, thickness: 1.0, thicknessCorrectionFactor: 1.0, finiteWidthCorrectionFactor: 1.0)
        // Default line resistance information used for all generated data
        let lineResistanceInfo = LineResistanceInfo(shouldCalculateLineResistance: true, voltageSensingGap: 0.02)
        
        // Generate initial sample and location information and create measurements for each combination
        for nextSample in self.generateInitialSampleInfo() {
            for nextLocation in self.generateInitalLocationInfo() {
                
                // Generate 4 measurements for each sample-location pair
                for _ in 1...4 {
                    let data = generateRandomResistance()
                    var localLocation = nextLocation
                    localLocation.measurementNumber += 1
                    
                    var localSample = nextSample
                    localSample.measurementNumber += 1
                    
                    // Add the new measurement to the data model
                    self.addNewMeasurement(withValue: data,
                                           withSampleInfo: localSample,
                                           locationInfo: localLocation,
                                           resistivityInfo: resistivityInfo,
                                           lineResistanceInfo: lineResistanceInfo,
                                           globalMeasurementNumber: self.measurementNumber)
                }
            }
        }
    }
    
    
    /// Generates an array of `SampleInfo` objects for initial testing data.
    /// - Returns: An array of `SampleInfo` with predefined names and sample numbers.
    private func generateInitialSampleInfo() -> [SampleInfo] {
        var localSamples:[SampleInfo] = []
        
        // Create 5 sample information objects with unique names and numbers
        for index in 1...5 {
            let newSample = SampleInfo(name: "Sample \(index)", sampleNumber: index)
            localSamples.append(newSample)
        }
        
        return localSamples
    }
    
    
    /// Generates an array of `LocationInfo` objects for initial testing data.
    /// - Returns: An array of `LocationInfo` with predefined names and location numbers.
    private func generateInitalLocationInfo() -> [LocationInfo] {
        var localLocations: [LocationInfo] = []
        
        // Create 5 location information objects with unique names and numbers
        for index in 1...5 {
            let newLocation = LocationInfo(name: "Location \(index)", locationNumber: index)
            localLocations.append(newLocation)
        }
        
        return localLocations
    }
    
    
    /// Generates a random resistance value within a specified range.
    /// - Returns: A `Double` representing a random resistance value.
    private func generateRandomResistance() -> Double {
        // Generate a random resistance value between 10.0 and 100.0
        return Double.random(in: 10.0...100.0)
    }
}

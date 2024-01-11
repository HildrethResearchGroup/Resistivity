//
//  DataModel_Measurements.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/10/24.
//

import Foundation

// MARK: - New Measurements
extension DataModel {
    /// Adds a new measurement to the current sample, creating a new sample if necessary.
    /// - Parameters:
    ///   - measurement: The resistivity measurement value to be added.
    ///   - sampleInfo: Information about the sample being measured.
    ///   - locationInfo: Information about the location where the measurement is taken.
    ///   - resistivityInfo: Additional information about the resistivity measurement.
    ///   - lineResistanceInfo: Information about the line resistance associated with the measurement.
    ///   - globalMeasurementNumber: A unique identifier for the measurement across all samples.
    func addNewMeasurement(withValue measurement: Double,
                           withSampleInfo sampleInfo: SampleInfo,
                           locationInfo: LocationInfo,
                           resistivityInfo: ResistivityMeasurementInfo,
                           lineResistanceInfo: LineResistanceInfo,
                           globalMeasurementNumber: Int) {
        
        // Check if a new sample is needed based on the provided sample information.
        if newSampleNeeded(sampleInfo) {
            self.createnewSample(withInfo: sampleInfo)
        }
        
        // Add the measurement to the current sample.
        self.currentSample?.addMeasurement(measurement,
                                           globalMeasurementNumber: globalMeasurementNumber,
                                           locationInfo: locationInfo,
                                           resistivityInfo: resistivityInfo,
                                           lineResistanceInfo: lineResistanceInfo)
        
        // Increment the local measurement number counter.
        measurementNumber += 1
    }
    
    /// Determines if a new sample is needed based on the provided sample information.
    /// - Parameter sampleInfo: The information about the sample to be compared with the current sample.
    /// - Returns: A Boolean value indicating whether a new sample is needed.
    private func newSampleNeeded(_ sampleInfo: SampleInfo) -> Bool {
        // Compare the name of the current sample with the provided sample information.
        if currentSample?.info.name != sampleInfo.name {
            return true
        }
        
        return false
    }
    
    /// Creates a new sample with the provided sample information if a new sample is needed.
    /// - Parameter sampleInfo: The information about the new sample to be created.
    private func createnewSample(withInfo sampleInfo: SampleInfo) {
        // Check if a new sample is needed before creating one.
        if newSampleNeeded(sampleInfo) {
            // Determine the sample number for the new sample.
            let sampleNumber = samples.count + 1
            
            // Copy the provided sample information and update the sample number.
            var sampleInfo = sampleInfo
            sampleInfo.sampleNumber = sampleNumber
            
            // Create a new sample with the updated information.
            let newSample = Sample(sampleInfo)
            
            // Append the new sample to the list of samples.
            samples.append(newSample)
        }
    }
}


// MARK: - Remove Measurements
extension DataModel {
    /// Deletes the specified measurements from all samples.
    /// - Parameter measurementsIn: An array of measurements to be deleted.
    func deleteMeasurements(_ measurementsIn: [Measurement]) {
        // Iterate over all samples and delete the specified measurements.
        for nextSample in samples {
            nextSample.deleteMeasurements(measurementsIn)
        }
    }
}

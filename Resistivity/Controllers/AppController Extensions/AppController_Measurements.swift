//
//  AppController_Measurements.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/10/24.
//

import Foundation

extension AppController {
    
    /// Initiates a series of resistance measurements asynchronously.
    /// This function starts a new task to measure resistance multiple times based on the measurement settings.
    /// It updates the nanovoltmeter status before and after the measurements and adds each new measurement
    /// to the data model. If an error occurs during the measurement process, it is printed to the console.
    func measureResistance() {
        Task {
            do {
                // Retrieve the number of measurements and the time interval between them from the measurement settings.
                let numberOfMeasurements = measurementSettings.numberOfMeasurements
                let timeBetweenMeasurements = measurementSettings.timeBetweenMeasurements
                
                // Update the nanovoltmeter status to measuring and store the previous status.
                let lastNanoVoltMeterStatus = nanoVoltMeterStatus
                nanoVoltMeterStatus = .measuring
                
                // Perform the resistance measurements asynchronously.
                let resistances = try await collectionController.measureResistance(times: numberOfMeasurements, withPeriod: timeBetweenMeasurements)
                
                // Update the data model with the new resistance measurements.
                for nextMeasurement in resistances {
                    dataModel.addNewMeasurement(withValue: nextMeasurement,
                                                withSampleInfo: sampleSettings.info(),
                                                locationInfo: locationSettings.info(),
                                                resistivityInfo: resistivitySettings.info(),
                                                lineResistanceInfo: lineResistanceSettings.info(),
                                                globalMeasurementNumber: globalMeasurementNumber)
                    
                    // Increment the global measurement number for each new measurement.
                    globalMeasurementNumber += 1
                }
                
                // Restore the nanovoltmeter status to its previous state.
                nanoVoltMeterStatus = lastNanoVoltMeterStatus
               
            } catch {
                // Print any errors that occur during the measurement process.
                print(error)
            }
        }
    }
    
    /// Retrieves information from the collection controller asynchronously.
    /// This function starts a new task to fetch information and updates the `information` property.
    /// If an error occurs during the information retrieval process, it is printed to the console.
    func getInformation() {
        Task {
            do {
                // Fetch information from the collection controller asynchronously.
                let info = try await collectionController.getInformation()
                // Update the `information` property with the retrieved information.
                information = info
            } catch {
                // Print any errors that occur during the information retrieval process.
                print(error)
            }
        }
    }
}

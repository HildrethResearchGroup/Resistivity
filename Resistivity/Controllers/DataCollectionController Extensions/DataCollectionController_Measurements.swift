//
//  DataCollectionController_Measurements.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/10/24.
//

import Foundation

// MARK: - Data Collection
extension DataCollectionController {
    
    /// Measures the resistance using the connected ohm meter.
    /// - Throws: `DataCollectionError.ohmMeterNotConnected` if the ohm meter is not connected,
    ///           `DataCollectionError.couldNotMeasureResistance` if the resistance could not be measured.
    /// - Returns: The measured resistance as a `Double`.
    func measureResistance() async throws -> Double {
        
        // Ensure the return mode is set to resistivity and flush old data if necessary
        if self.returnMode != .resistivity {
            self.returnMode = .resistivity
            
            await self.flushOldData(for: .resistivity)
        }
        
        // Store the current equipment status to restore it later
        let storedEquipmentStatus = equipmentStatus
        
        // Throw an error if the ohm meter is not connected
        if equipmentStatus == .disconnected {
            throw DataCollectionError.ohmMeterNotConnected
        }
        
        // Set the equipment status to measuring
        equipmentStatus = .measuring
        
        // Attempt to get the resistance from the ohm meter and handle possible errors
        guard let resistance = try await ohmMeter?.getResistance() else {
            equipmentStatus = storedEquipmentStatus
            throw DataCollectionError.couldNotMeasureResistance
        }
        
        // Restore the equipment status and return the measured resistance
        equipmentStatus = storedEquipmentStatus
        return resistance
    }
    
    /// Measures the resistance multiple times with a specified period between measurements.
    /// - Parameters:
    ///   - numberOfMeasurements: The number of times to measure the resistance.
    ///   - seconds: The time interval in seconds between measurements.
    /// - Throws: `DataCollectionError` if any measurement fails.
    /// - Returns: An array of measured resistances.
    func measureResistance(times numberOfMeasurements: Int, withPeriod seconds: Double) async throws -> [Double] {
        
        // Create an array to store the measurements
        var measurements: [Double] = []
        
        // Check to make sure inputs are valid
        if numberOfMeasurements < 1 || seconds.sign == .minus {
            return measurements
        }
        
        // Perform the measurements the specified number of times
        for _ in 1...numberOfMeasurements {
            let nextResistance = try await self.measureResistance()
            
            // Delay for the minimum time required between measurements
            usleep(NanoVoltMeterController.minimumDelay)
            
            // Append the measured resistance to the measurements array
            measurements.append(nextResistance)
        }
        
        // Return the array of measurements
        return measurements
    }
    
    
    
    /// Retrieves the identifier information from the connected ohm meter.
    /// - Throws: `DataCollectionError.ohmMeterNotConnected` if the ohm meter is not connected,
    ///           `DataCollectionError.couldNotGetInstrumentInformation` if the information could not be retrieved.
    /// - Returns: The identifier information as a `String`.
    func getInformation() async throws -> String {
        
        // Ensure the return mode is set to identifier and flush old data if necessary
        if self.returnMode != .identifier {
            self.returnMode = .identifier
            await self.flushOldData(for: .identifier)
        }
        
        // Throw an error if the ohm meter is not connected
        if equipmentStatus == .disconnected {
            throw DataCollectionError.ohmMeterNotConnected
        }
        
        // Attempt to get the identifier from the ohm meter and handle possible errors
        guard let info = try await ohmMeter?.getIdentifier() else {
            throw DataCollectionError.couldNotGetInstrumentInformation
        }
        
        // Return the retrieved identifier information
        return info
    }
    
    
    
    /// Flushes old data from the ohm meter by querying new data until new data is returned.
    /// This is done to ensure compatibility between old and new data.
    /// - Parameter returnMode: The mode in which the data should be returned.
    func flushOldData(for returnMode: ReturnMode) async {
        switch returnMode {
        case .identifier:
            // Flush old identifier data
            for _ in 0..<3 {
                _ = try? await self.getInformation()
                usleep(NanoVoltMeterController.minimumDelay)
            }
        case .resistivity:
            // Flush old resistivity data
            for _ in 0..<3 {
                _ = try? await self.measureResistance()
                usleep(NanoVoltMeterController.minimumDelay)
            }
        }
    }
}

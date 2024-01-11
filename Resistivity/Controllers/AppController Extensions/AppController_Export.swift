//
//  AppController_Export.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/10/24.
//

import Foundation

/// Extension of `AppController` to handle exporting data to files.
extension AppController {
    
    /// Exports data to a specified URL. This function will create two separate files, one for raw data and one for summary data.
    /// - Parameter url: The base URL where the data files will be saved. If nil, an error is thrown.
    /// - Throws: `ExportError.URLwasNil` if the provided URL is nil.
    func exportData(to url: URL?) throws {
        // Ensure the URL is not nil, otherwise throw an error.
        guard let localURL = url else {throw ExportError.URLwasNil}
        
        // Remove the file extension from the URL and extract the file name and directory.
        let extensionLessURL = localURL.deletingPathExtension()
        let fileName = extensionLessURL.lastPathComponent
        let saveDirectory = extensionLessURL.deletingLastPathComponent()
        
        // Create file names for raw and summary data by appending suffixes to the base file name.
        let rawDataFileName = fileName + "_RawData.csv"
        let summaryDataFileName = fileName + "_SummaryData.csv"
        
        // Construct the full URLs for the raw and summary data files.
        let rawDataURL = saveDirectory.appending(path: rawDataFileName)
        let summaryDataURL = saveDirectory.appending(path: summaryDataFileName)
        
        // Initialize an instance of ExportManager to handle the data export.
        let exportManager = ExportManager()
        
        // Export the flattened measurements as raw data to the specified URL.
        try exportManager.export(self.dataModel.flattendMeasurements, to: rawDataURL)
        
        // Export the samples as summary data to the specified URL.
        try exportManager.export(self.dataModel.samples, to: summaryDataURL)
    }
    
    /// Exports combined data to a specified URL. This function will create a single file containing both measurements and samples.
    /// - Parameter url: The URL where the combined data file will be saved. If nil, an error is thrown.
    /// - Throws: `ExportError.URLwasNil` if the provided URL is nil.
    func exportCombinedData(to url: URL?) throws {
        // Ensure the URL is not nil, otherwise throw an error.
        guard let localURL = url else {throw ExportError.URLwasNil}
        
        // Initialize an instance of ExportManager to handle the data export.
        let exportManager = ExportManager()
        // Retrieve the flattened measurements and samples from the data model.
        let localMeasurements = self.dataModel.flattendMeasurements
        let localSamples = self.dataModel.samples
        
        // Export the combined file containing both measurements and samples to the specified URL.
        try exportManager.exportCombinedFile(measurements: localMeasurements, samples: localSamples, to: localURL)
    }
    
    /// Enumeration defining the possible errors that can occur during the export process.
    enum ExportError: Error {
        case URLwasNil // Indicates that the provided URL for exporting data was nil.
    }
}

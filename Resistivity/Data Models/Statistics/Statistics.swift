//
//  Statistics.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/7/23.
//

import Foundation

/// A structure to calculate and store statistical properties of a collection of elements.
/// The elements must be comparable and contain a property of type `Double` that can be accessed via a `KeyPath`.
struct Statistics<Element: Comparable> {
    typealias T = Double // Defines a typealias for the Double type to be used within the structure.
    let keyPath: KeyPath<Element,  T> // The key path to the property of the element that will be used for statistical calculations.
    var name: String // The name of the statistical metric.
    var units: String // The units of the statistical metric.
    
    var mean: Double = 0.0 // The mean (average) value of the elements.
    var standardDeviation: Double = 0.0 // The standard deviation of the elements.
    var min: Double = 0.0 // The minimum value among the elements.
    var max: Double = 0.0 // The maximum value among the elements.
    
    /// Updates the statistical properties using a new collection of elements.
    /// - Parameter items: The collection of elements to calculate statistics from.
    mutating func update(with items: [Element]) {
        // Calculate the mean of the elements, if it fails, reset the statistics.
        guard let localMean = try? items.mean(withPath: keyPath) else {
            reset()
            return
        }
        
        // Calculate the standard deviation of the elements, if it fails, reset the statistics.
        guard let localStdDev = try? items.standardDeviation(withPath: keyPath) else {
            reset()
            return
        }
        
        // Calculate the minimum value among the elements, if it fails, reset the statistics.
        guard let localMin = items.min() else {
            reset()
            return
        }
        
        // Calculate the maximum value among the elements, if it fails, reset the statistics.
        guard let localMax = items.max() else {
            reset()
            return
        }
        
        // Update the statistical properties with the calculated values.
        mean = localMean
        standardDeviation = localStdDev
        min = localMin[keyPath: keyPath] as Double
        max = localMax[keyPath: keyPath] as Double
    }
    
    /// Resets the statistical properties to their default values.
    private mutating func reset() {
        mean = 0.0
        standardDeviation = 0.0
    }
}

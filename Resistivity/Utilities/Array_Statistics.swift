//
//  StatisticsCalculator.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/7/23.
//

import Foundation

/// Extension of the Array type to provide statistical calculation methods for arrays of floating point numbers.
extension Array {
    
    /// Calculates the sum of elements in the array based on a given key path.
    ///
    /// - Parameter keyPath: A key path of the element's property to be summed up.
    /// - Returns: The sum of the elements' properties as a Double.
    func sum<T: FloatingPoint >(withPath keyPath: KeyPath<Element, T>) -> Double {
        var sum = 0.0
        for nextItem in self {
            if let nextDouble = nextItem[keyPath: keyPath] as? Double {
                sum += nextDouble
            }
        }
        return sum
    }
    
    /// Calculates the mean (average) of elements in the array based on a given key path.
    ///
    /// - Parameter keyPath: A key path of the element's property for which the mean is to be calculated.
    /// - Throws: `CalculatorError.arrayIsEmpty` if the array is empty.
    ///           `CalculatorError.sumIsZero` if the sum of the elements' properties is zero.
    /// - Returns: The mean of the elements' properties as a Double.
    func mean<T: FloatingPoint >( withPath keyPath: KeyPath<Element, T>) throws -> Double {
        let size = self.count
        
        if size == 0 {
            throw CalculatorError.arrayIsEmpty
        }
        
        let sum = sum(withPath: keyPath)
        
        if sum == 0.0 {
            throw CalculatorError.sumIsZero
        }
        
        return sum / Double(size)
    }
    
    /// Calculates the standard deviation of elements in the array based on a given key path.
    ///
    /// - Parameter keyPath: A key path of the element's property for which the standard deviation is to be calculated.
    /// - Throws: `CalculatorError.arrayIsEmpty` if the array is empty.
    ///           `CalculatorError.sumIsZero` if the sum of the elements' properties is zero.
    /// - Returns: The standard deviation of the elements' properties as a Double.
    func standardDeviation<T: FloatingPoint>( withPath keyPath: KeyPath<Element, T>) throws -> Double {
        let localMean = try mean(withPath: keyPath)
        
        var squares = 0.0
        
        for nextItem in self {
            if let nextDouble = nextItem[keyPath: keyPath] as? Double {
                let nextDifference = (nextDouble - localMean)
                squares += nextDifference*nextDifference
            }
        }
        
        let interior = squares / Double(self.count)
        
        let stdDev = sqrt(interior)
        
        return stdDev
    }
    
    /// An enumeration of errors that can be thrown by the statistical calculation methods.
    enum CalculatorError: Error {
        case sumIsZero
        case arrayIsEmpty
    }
}

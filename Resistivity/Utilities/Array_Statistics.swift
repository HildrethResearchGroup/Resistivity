//
//  StatisticsCalculator.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/7/23.
//

import Foundation


extension Array {
    func sum<T: FloatingPoint >(withPath keyPath: KeyPath<Element, T>) -> Double {
        var sum = 0.0
        for nextItem in self {
            if let nextDouble = nextItem[keyPath: keyPath] as? Double {
                sum += nextDouble
            }
        }
        return sum
    }
    
    
    func mean<T: FloatingPoint >( withPath keyPath: KeyPath<Element, T>) throws -> Double {
        let size = self.count
        
        if size == 0 {
            throw CalculatorError.arrayIsempty
        }
        
        let sum = sum(withPath: keyPath)
        
        if sum == 0.0 {
            throw CalculatorError.sumIsZero
        }
        
        return sum / Double(size)
    }
    
    func standardDeviation<T: FloatingPoint>( withPath keyPath: KeyPath<Element, T>) throws -> Double {
        let localMean = try mean(withPath: keyPath)
        
        var squares = 0.0
        
        for nextItem in self {
            if let nextDouble = nextItem[keyPath: keyPath] as? Double {
                let nextDifference = nextDouble - localMean
                squares += nextDifference
            }
        }
        
        let interior = squares / Double(self.count)
        
        let stdDev = sqrt(interior)
        
        return stdDev
        
    }
    
    enum CalculatorError: Error {
        case sumIsZero
        case arrayIsempty
    }
}


//
//  Statistics.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/7/23.
//

import Foundation

struct Statistics<Element: Comparable> {
    typealias T = Double
    let keyPath: KeyPath<Element,  T>
    var name: String
    var units: String
    
    var mean: Double = 0.0
    var standardDeviation: Double = 0.0
    var min: Double = 0.0
    var max: Double = 0.0
    
    mutating func update(with items: [Element]) {
        guard let localMean = try? items.mean(withPath: keyPath) else {
            reset()
            return
        }
        
        guard let localStdDev = try? items.standardDeviation(withPath: keyPath) else {
            reset()
            return
        }
        
        
         guard let localMin = items.min() else {
             reset()
             return
         }
         
        
        guard let localMax = items.max() else {
            reset()
            return
        }
        
        
        mean = localMean
        standardDeviation = localStdDev
        min = localMin[keyPath: keyPath] as Double
        max = localMax[keyPath: keyPath] as Double
    }
    
    private mutating func reset() {
        mean = 0.0
        standardDeviation = 0.0
    }
}

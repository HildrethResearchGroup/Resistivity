//
//  Statistics.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/7/23.
//

import Foundation

struct Statistics<Element> {
    typealias T = Double
    let keyPath: KeyPath<Element,  T>
    var name: String
    var units: String
    
    var mean: Double = 0.0
    var standardDeviation: Double = 0.0
    
    mutating func update(with items: [Element]) {
        guard let localMean = try? items.mean(withPath: keyPath) else {
            reset()
            return
        }
        
        guard let localStdDev = try? items.standardDeviation(withPath: keyPath) else {
            reset()
            return
        }
        
        mean = localMean
        standardDeviation = localStdDev
    }
    
    private mutating func reset() {
        mean = 0.0
        standardDeviation = 0.0
    }
}

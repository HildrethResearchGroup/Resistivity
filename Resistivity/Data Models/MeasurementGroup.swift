//
//  MeasurementsViewModel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation

class MeasurementGroup {
    
    var measurements: [Measurement] = [] {
        didSet {
            updateStatistics()
        }
    }
    
    var sampleName = ""
    var location = ""
    
    var resistanceStatistics = Statistics<Measurement>(keyPath: \.resistance, name: "Resistance", units: "Ω")
    var resistivityStatistics = Statistics<Measurement>(keyPath: \.resistivity, name: "Resistivity", units: "Ω-m")
    
    private func updateStatistics() {
        resistanceStatistics.update(with: measurements)
        resistivityStatistics.update(with: measurements)
    }
}

extension MeasurementGroup {
    func save() {
        print("Save")
    }
}


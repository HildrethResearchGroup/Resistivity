//
//  StatisticsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/11/24.
//

import SwiftUI

struct StatisticsView: View {
    var title: String
    var units: any ConvertableUnits
    var statistics: any Statistic
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.title2)
            Text("µ = " + formatted(mean) + " " + unitsDisplay)
            Text("σ = " + formatted(stdDev) + " " + unitsDisplay)
            Text("min = " + formatted(min) + " " + unitsDisplay)
            Text("max = " + formatted(max) + " " + unitsDisplay)
        }
    }
    
    
    
    func formatted(_ valueIn: Double) -> String {
        let number = NSNumber(value: valueIn)
        
        return formatter.string(from: number) ?? "NaN"
    }
    
    private let formatter = NumberFormatter.shortNumber
    
    var unitsDisplay: String {
        String(units.description)
    }
    
    func scaled(_ valueIn: Double) -> Double {
        valueIn * units.scaleFactor()
    }
    
    var mean: Double { scaled(statistics.mean) }
    var stdDev: Double { scaled(statistics.standardDeviation) }
    var min: Double { scaled(statistics.min) }
    var max: Double { scaled(statistics.max) }
}


//
//  GraphPreview.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/12/24.
//

import SwiftUI
import Charts

struct GraphPreview: View {
    
    typealias T = Double
    
    let title:String
    
    let keyPath: KeyPath<Measurement,  T>
    
    var units: any ConvertableUnits
    
    private let fontColor = Color.black
    
    let formatter = NumberFormatter.shortNumber
    
    var measurements: [Measurement]
    
    var body: some View {
        VStack {
            Text("\(title) \(unitsDisplay)")
            chart
        }
    }
    
    @ViewBuilder
    var chart: some View {
        Chart(measurements) { nextMeasurement in
            LineMark(x: .value("Measurement #", nextMeasurement.globalMeasurementNumber),
                     y: .value(title, scaledData(for: nextMeasurement)))
            .foregroundStyle(by: .value("Sample", nextMeasurement.sampleInfo.name))
            .lineStyle(StrokeStyle(dash: [9, 10]))
            
            PointMark(x: .value("Measurement #", nextMeasurement.globalMeasurementNumber),
                      y: .value(title, scaledData(for: nextMeasurement)))
            .foregroundStyle(by: .value("Sample", nextMeasurement.sampleInfo.name))
            .symbol(by: .value("Sample", nextMeasurement.sampleInfo.name))
        }
        .foregroundStyle(fontColor)
        .chartLegend(.hidden)
        .chartXAxis(.hidden)
        
        .chartYAxis() {
            AxisMarks(position: .leading) { _ in
                AxisTick()
                    .foregroundStyle(fontColor)
                AxisValueLabel()
                    .foregroundStyle(fontColor)
                AxisGridLine().foregroundStyle(fontColor)
            }
        }
        .chartPlotStyle { plotContent in
            plotContent
                .foregroundStyle(fontColor)
                .background(.white)
                .border(.white)
        }
    }
}


// MARK: - Display Data
extension GraphPreview {
    
    func scaledData(for measurement: Measurement) -> Double {
        let data = measurement[keyPath: keyPath]
        return units.scaledFromBaseValue(data)
    }
    
    func formatedData(for measurement: Measurement) -> String {
        let data = scaledData(for: measurement)
        
        let number = NSNumber(value: data)
        
        return formatter.string(from: number) ?? "NaN"
    }
    
}

// MARK: - Titles
extension GraphPreview {
    var unitsDisplay: String {
        let unitsString = String(units.description)
        
        return "[" + unitsString + "]"
    }
}




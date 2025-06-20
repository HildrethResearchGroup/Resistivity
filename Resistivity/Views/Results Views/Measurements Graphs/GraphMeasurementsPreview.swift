//
//  GraphPreview.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/12/24.
//

import SwiftUI
import Charts

struct GraphMeasurementsPreview: View {
    
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
                .foregroundStyle(fontColor)
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
            .symbolSize(10.0)
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
extension GraphMeasurementsPreview {
    
    func scaledData(for measurement: Measurement) -> Double {
        let data = measurement[keyPath: keyPath]
        return units.scaledToBaseValue(data)
    }
    
    func formatedData(for measurement: Measurement) -> String {
        let data = scaledData(for: measurement)
        
        let number = NSNumber(value: data)
        
        return formatter.string(from: number) ?? "NaN"
    }
    
}

// MARK: - Titles
extension GraphMeasurementsPreview {
    var unitsDisplay: String {
        let unitsString = String(units.description)
        
        return "[" + unitsString + "]"
    }
}




// MARK: - Previews
struct GraphPreview_Previews: PreviewProvider {
    static var previews: some View {
        let units: ResistanceUnits = .ohms
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        GraphMeasurementsPreview(title: "Resistance", keyPath: \.resistance, units: units, measurements: dataViewModel.measurements)
    }
}

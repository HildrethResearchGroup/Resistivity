//
//  GraphSummaryPreview.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/13/24.
//

import SwiftUI
import Charts

struct GraphSummaryPreview: View {
    
    let title:String
    
    let keyPath: KeyPath<Sample, Statistics<Measurement>>
    
    var units: any ConvertableUnits
    
    var samples: [Sample]
    
    @State private var rawSelectedSample: Int?
    
    private var selectedSample: Sample? {
        guard let rawSelection = rawSelectedSample else {return nil}
        
        
        return samples.first(where: {$0.info.sampleNumber == rawSelection})
    }
    
    private let fontColor = Color.black
    
    private let formatter = NumberFormatter.shortNumber
    
    private var scaleFactor: Double { units.scaleFactor() }
    
    
    var body: some View {
        VStack {
            Text("\(title) [\(units.description)]")
                .foregroundStyle(fontColor)
            Chart(samples) { nextSample in
                let statistics = nextSample[keyPath: keyPath]
                
                let x = nextSample.info.sampleNumber
                let y_mean = statistics.mean * scaleFactor
                let y_stdDevPlus = y_mean + statistics.standardDeviation * scaleFactor
                let y_stdDevMinus = y_mean - statistics.standardDeviation * scaleFactor
                
                let name = nextSample.info.name
                
                RectangleMark(x: .value("Sample #", x), yStart: .value(title, y_stdDevPlus), yEnd: .value(title, y_stdDevMinus))
                    .foregroundStyle(by: .value("Sample", name))
                    .opacity(0.3)
                    //.symbol(by: .value("Sample", name))
                
                PointMark(x: .value("Sample #", x), y: .value(title, y_mean))
                    .foregroundStyle(by: .value("Sample", name))
                    .symbol(by: .value("Sample", name))
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
                    AxisGridLine()
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
}




// MARK: - Previews
struct GraphSummaryPreview_Previews: PreviewProvider {
    static var previews: some View {
        let units: ResistanceUnits = .ohms
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        GraphSummaryView(title: "Resistance", keyPath: \.resistanceStatistics, units: units, samples: dataViewModel.filteredSamples)
    }
}


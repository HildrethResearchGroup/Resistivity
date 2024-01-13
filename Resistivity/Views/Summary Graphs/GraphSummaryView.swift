//
//  GraphSummaryView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/13/24.
//

import SwiftUI
import Charts

struct GraphSummaryView: View {
    
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
                .font(.title)
                .foregroundStyle(fontColor)
            ZStack {
                
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
                        .symbol(by: .value("Sample", name))
                    
                    PointMark(x: .value("Sample #", x), y: .value(title, y_mean))
                        .foregroundStyle(by: .value("Sample", name))
                        .symbol(by: .value("Sample", name))
                    
                    if let selectedSample {
                        RuleMark(x: .value("Selected", selectedSample.info.sampleNumber))
                        .foregroundStyle(Color.gray.opacity(0.2))
                        .offset(yStart: -10)
                        .zIndex(-2)
                      }
                }
                .chartXSelection(value: $rawSelectedSample)
                .chartLegend(position: .trailing, alignment: .top)
                .foregroundStyle(fontColor)
                .chartXAxisLabel(position: .bottom, alignment: .center) {
                    Text("Sample # [-]")
                        .font(.title)
                        .foregroundStyle(fontColor)
                }
                .chartXAxis() {
                    AxisMarks() {
                        AxisTick(length: 10, stroke: StrokeStyle(lineWidth: 1))
                            .foregroundStyle(fontColor)
                        AxisValueLabel()
                            .font(.title)
                            .foregroundStyle(fontColor)
                        AxisGridLine(stroke: StrokeStyle(dash: [10,0])).foregroundStyle(fontColor)
                    }
                    
                }

                .chartYAxis() {
                    AxisMarks(position: .leading) { _ in
                        AxisTick(length: 10, stroke: StrokeStyle(lineWidth: 1))
                            .foregroundStyle(fontColor)
                        AxisValueLabel().font(.title)
                            .font(.title)
                            .foregroundStyle(fontColor)
                        AxisGridLine(stroke: StrokeStyle(dash: [10,0])).foregroundStyle(fontColor)
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
        .padding()
        .overlay( selectionOverlay().padding(), alignment: .topLeading )
    }
    
    func formattedData(_ valueIn: Double) -> String {
        let number = NSNumber(value: valueIn)
        
        return formatter.string(from: number) ?? "NaN"
    }
    
    @ViewBuilder
    func selectionOverlay() -> some View {
        let scaleFactor = scaleFactor
        if let sample = selectedSample {
            let statistics = sample[keyPath: keyPath]
            
            let mean = formattedData(statistics.mean * scaleFactor)
            let stdDev = formattedData(statistics.standardDeviation * scaleFactor)
            let max = formattedData(statistics.max * scaleFactor)
            let min = formattedData(statistics.min * scaleFactor)
            
            VStack(alignment: .leading) {
                Text("\(title) [\(units.description)]")
                Text(sample.info.name)
                Text("µ: \(mean) \(units.description)")
                Text("Std.: \(stdDev) \(units.description)")
                Text("Min: \(min) \(units.description)")
                Text("Max: \(max) \(units.description)")
            }
            .font(.callout)
            .background(.white.opacity(0.95), in: RoundedRectangle(cornerRadius: 8))
        } else {
            EmptyView()
        }
    }
}




// MARK: - Previews
struct GraphSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let units: ResistanceUnits = .ohms
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        GraphSummaryView(title: "Resistance", keyPath: \.resistanceStatistics, units: units, samples: dataViewModel.filteredSamples)
    }
}


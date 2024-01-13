//
//  GraphView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/12/24.
//

import SwiftUI
import Charts

struct GraphMeasurementsView: View {
    typealias T = Double
    
    let title:String
    
    let keyPath: KeyPath<Measurement,  T>
    
    var units: any ConvertableUnits
    
    @State var rawSelectedMeasurement: Int?
    
    private let fontColor = Color.black
    
    let formatter = NumberFormatter.shortNumber
    
    var measurements: [Measurement]
    
    var body: some View {
        VStack {
            Text("\(title) \(unitsDisplay)")
                .font(.title)
                .foregroundStyle(fontColor)
            ZStack {
                Chart(measurements) { nextMeasurement in
                    LineMark(x: .value("Measurement #", nextMeasurement.globalMeasurementNumber),
                             y: .value(title, scaledData(for: nextMeasurement)),
                             series: .value("Sample", nextMeasurement.sampleInfo.name))
                    .foregroundStyle(by: .value("Sample", nextMeasurement.sampleInfo.name))
                    //.symbol(by: .value("Sample", nextMeasurement.sampleInfo.name))
                    .lineStyle(StrokeStyle(dash: [9, 10]))
                    
                    PointMark(x: .value("Measurement #", nextMeasurement.globalMeasurementNumber),
                              y: .value(title, scaledData(for: nextMeasurement)))
                    .foregroundStyle(by: .value("Sample", nextMeasurement.sampleInfo.name))
                    .symbol(by: .value("Sample", nextMeasurement.sampleInfo.name))
                    
                    if let selectedMeasurent {
                        RuleMark(x: .value("Selected", selectedMeasurent.globalMeasurementNumber))
                            .foregroundStyle(Color.gray.opacity(0.2))
                            .offset(yStart: -10)
                            .zIndex(-2)
                    }
                }
                .chartXSelection(value: $rawSelectedMeasurement)
                .chartLegend(position: .trailing, alignment: .top)
                .foregroundStyle(fontColor)
                .chartXAxisLabel(position: .bottom, alignment: .center) {
                    Text("Measurement # [-]")
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
                .padding()
            }
            
        }.overlay(selectionOverlay(), alignment: .topLeading)
        
    }
    
    
}


// MARK: - Display Data
extension GraphMeasurementsView {
    
    func scaledData(for measurement: Measurement) -> Double {
        let data = measurement[keyPath: keyPath]
        return units.scaledFromBaseValue(data)
    }
    
    func formatedData(for measurement: Measurement) -> String {
        let data = scaledData(for: measurement)
        
        let number = NSNumber(value: data)
        
        return formatter.string(from: number) ?? "NaN"
    }
    
    
    private var selectedMeasurent: Measurement? {
        guard let rawSelection = rawSelectedMeasurement else { return nil }
        
        return measurements.first(where: {$0.globalMeasurementNumber == rawSelection} )
    }
    
    @ViewBuilder
    func selectionOverlay() -> some View {
        if let selection = selectedMeasurent {
            VStack(alignment: .leading) {
                Text(selection.sampleInfo.name)
                Text(selection.locationInfo.name)
                Text("ID: \(selection.sampleID)")
                Text("\(title): \(formatedData(for:selection)) \(unitsDisplay)")
            }
            .frame(width: 100)
            .padding()
            .background(.white, in: RoundedRectangle(cornerRadius: 8))
        } else {
            EmptyView()
        }
    }
    
}

// MARK: - Titles
extension GraphMeasurementsView {
    var unitsDisplay: String {
        let unitsString = String(units.description)
        
        return "[" + unitsString + "]"
    }
}


// MARK: - Rotating Y-Axis Label
extension GraphMeasurementsView {
    struct WhiteGroupBoxStyle: GroupBoxStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.content
                .padding(.top, 30)
                .padding(20)
                .background(.white)
                .cornerRadius(20)
                .overlay(
                    configuration.label.padding(10),
                    alignment: .topLeading
                )
        }
    }
}



// MARK: - Previews
struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        let units: ResistanceUnits = .ohms
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        GraphMeasurementsView(title: "Resistance", keyPath: \.resistance, units: units, measurements: dataViewModel.measurements)
    }
}

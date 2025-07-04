//
//  GraphView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/12/24.
//

import SwiftUI
import Charts

struct GraphMeasurementsView: View {
    
    let title:String
    
    let keyPath: KeyPath<Measurement,  Double>
    
    var units: any ConvertableUnits
    
    var measurements: [Measurement]
    
    @State private var rawSelectedMeasurement: Int?
    
    private let fontColor = Color.black
    
    private let formatter = NumberFormatter.shortNumber
    
    @State private var showDashedLines = false
    
    
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
                    .lineStyle(lineStyle)
                    
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
            }
            .contextMenu {
                Toggle(isOn: $showDashedLines) {
                    if showDashedLines {
                        Text("Hide Lines")
                    } else {
                        Text("Show Lines")
                    }
                }
            }

            
        }
        .padding()
        .overlay(selectionOverlay().padding(), alignment: .topLeading)
        
    }
    
    private var lineStyle: StrokeStyle {
        if showDashedLines == true {
            return StrokeStyle(dash: [9, 10])
        } else {
            return StrokeStyle(lineWidth: 0)
        }
    }
    
    
}


// MARK: - Display Data
extension GraphMeasurementsView {
    
    func scaledData(for measurement: Measurement) -> Double {
        let data = measurement[keyPath: keyPath]
        return units.scaledToBaseValue(data)
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
                Text("\(title) [\(units.description)]")
                Text(selection.sampleInfo.name)
                Text(selection.locationInfo.name)
                Text("ID: \(selection.sampleID)")
                Text("\(title): \(formatedData(for:selection)) \(units.description)")
            }
            .font(.callout)
            .background(.white.opacity(0.95), in: RoundedRectangle(cornerRadius: 8))
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

//
//  ResultsGraphView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/29/23.
//

import SwiftUI
import Charts

struct ResultsResistanceGraphView: View {
    @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
    
    @State var rawSelectedMeasurement: Int?
    
    private var selectedMeasurent: Measurement? {
        guard let rawSelection = rawSelectedMeasurement else { return nil }
        
        return measurements.first(where: {$0.globalMeasurementNumber == rawSelection} )
    }
    
    let fontColor: Color = .black
    
    var measurements: [Measurement]
    
    var body: some View {
        ZStack {
            Chart(measurements) { nextMeasurement in
                LineMark(x: .value("Measurement #", nextMeasurement.globalMeasurementNumber),
                         y: .value("Resistance", nextMeasurement.scaledResistance(resistanceUnits)),
                         series: .value("Sample", nextMeasurement.sampleInfo.name))
                    .foregroundStyle(by: .value("Sample", nextMeasurement.sampleInfo.name))
                    //.symbol(by: .value("Sample", nextMeasurement.sampleInfo.name))
                    .lineStyle(StrokeStyle(dash: [9, 10]))
                
                 PointMark(x: .value("Measurement #", nextMeasurement.globalMeasurementNumber),
                           y: .value("Resistance", nextMeasurement.scaledResistance(resistanceUnits)))
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
            .chartYAxisLabel(position: .leading, alignment: .center) {
                 Text("Resistance \(resistanceUnitsDisplay)")
                     .scaledToFit()
                     .frame(width: 200, height: 200)
                     .offset(x: 0, y: 75)
                     .rotationEffect(.degrees(180))
                     .font(.title)
                     .foregroundStyle(fontColor)
      
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
            .offset(x: -100, y: 0)
            .padding()
        }
        .overlay(selectionOverlay().padding(), alignment: .topLeading)
    }
    
    @ViewBuilder
    func selectionOverlay() -> some View {
        let scaleFactor = resistanceUnits.scaleFactor()
        if let selection = selectedMeasurent {
            VStack(alignment: .leading) {
                Text(selection.sampleInfo.name)
                Text("Loc.: \(selection.locationInfo.name)")
                Text("ID: \(selection.sampleID)")
                Text("Resistance: \(selection.resistance * scaleFactor) \(resistanceUnitsDisplay)")
            }
        } else {
            EmptyView()
        }
    }
    
    
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
    
    var resistanceUnitsDisplay: String {
        get {
            let unitsString = String(resistanceUnits.description)
            
            return "[" + unitsString + "]"
        }
    }    
}

struct ResultsGraphView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        ResultsResistanceGraphView(measurements: dataModel.flattendMeasurements)
    }
}

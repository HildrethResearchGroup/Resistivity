//
//  ResultsGraphView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/29/23.
//

import SwiftUI
import Charts

struct ResultsGraphView: View {
    
    let fontColor: Color = .black
    
    var measurements: [Measurement]
    
    var body: some View {
        Chart(measurements) { nextMeasurement in
            LineMark(x: .value("Measurement #", nextMeasurement.globalMeasurementNumber), y: .value("Resistance", nextMeasurement.resistance), series: .value("Sample", nextMeasurement.sampleInfo.name))
                .foregroundStyle(by: .value("Sample", nextMeasurement.sampleInfo.name))
                //.symbol(by: .value("Sample", nextMeasurement.sampleInfo.name))
                .lineStyle(StrokeStyle(dash: [9, 10]))
            
             PointMark(x: .value("Measurement #", nextMeasurement.globalMeasurementNumber), y: .value("Resistance", nextMeasurement.resistance))
                .foregroundStyle(by: .value("Sample", nextMeasurement.sampleInfo.name))
                .symbol(by: .value("Sample", nextMeasurement.sampleInfo.name))
            
        }
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
             Text("Resistance [Ω]")
                 .scaledToFit()
                 .frame(width: 150, height: 150)
                 .offset(x: 0, y: 50)
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
        .offset(x: -50, y: 0)
        .padding()
        
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
    
    
    
}

struct ResultsGraphView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        ResultsGraphView(measurements: dataModel.flattendMeasurements)
    }
}

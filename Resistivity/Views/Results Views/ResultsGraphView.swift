//
//  ResultsGraphView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/29/23.
//

import SwiftUI
import Charts

struct ResultsGraphView: View {
    
    var measurements: [Measurement]
    
    var body: some View {
        GroupBox() {
            Chart(measurements) { nextMeasurement in
                LineMark(x: .value("Measurement #", nextMeasurement.globalMeasurementNumber), y: .value("Resistance", nextMeasurement.resistance), series: .value("Sample", nextMeasurement.sampleInfo.name))
                    .foregroundStyle(by: .value("Sample", nextMeasurement.sampleInfo.name))
                    .symbol(by: .value("Sample", nextMeasurement.sampleInfo.name))
                    .lineStyle(StrokeStyle(dash: [9, 10]))
                
                
                /*
                 PointMark(x: .value("Measurement #", nextMeasurement.globalMeasurementNumber), y: .value("Resistance", nextMeasurement.resistance))
                 
                 */
                
            }
            .chartLegend(position: .trailing, alignment: .top)
            .chartXAxisLabel(position: .bottom, alignment: .center) {
                Text("Measurement # [-]")
            }
            
            .chartYAxis() {
                AxisMarks(position: .leading)
            }
            
            .chartYAxisLabel(position: .leading, alignment: .center) {
                Text("Resistance [Ω]")
                    .rotationEffect(.degrees(180), anchor: .center)
                    .frame(width: 80, height: 80)
            }
        } label: {
            Text("Resistance Measurements")
                .font(.title)
        }
        .groupBoxStyle(WhiteGroupBoxStyle())
        
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
        ResultsGraphView(measurements: dataModel.sortedMeasurements)
    }
}

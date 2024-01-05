//
//  ResultsSummaryGraphView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/4/24.
//

import SwiftUI
import Charts

struct ResultsSummaryGraphView: View {
    @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
    
    var samples: [Sample]
    let fontColor: Color = .black
    
    var scaleFactor: Double { resistanceUnits.scaleFactor() }
    
    var body: some View {
        Chart(samples) { nextSample in
            let x = nextSample.info.sampleNumber
            let y_mean = nextSample.resistanceStatistics.mean * scaleFactor
            let y_stdDevPlus = y_mean + nextSample.resistanceStatistics.standardDeviation * scaleFactor
            let y_stdDevMinus = y_mean - nextSample.resistanceStatistics.standardDeviation * scaleFactor
            
            let name = nextSample.info.name
            
            RectangleMark(x: .value("Sample #", x), yStart: .value("Resistance", y_stdDevPlus), yEnd: .value("Resistance", y_stdDevMinus))
                .foregroundStyle(by: .value("Sample", name))
                .opacity(0.3)
                .symbol(by: .value("Sample", name))
            
            PointMark(x: .value("Sample #", x), y: .value("Resistance", y_mean))
                .foregroundStyle(by: .value("Sample", name))
                .symbol(by: .value("Sample", name))
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





struct ResultsSummaryGraphView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        ResultsSummaryGraphView(samples: dataModel.samples)
    }
}

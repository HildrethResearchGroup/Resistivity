//
//  SummaryStatisticsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct SummaryStatisticsView: View {
    
    @ObservedObject var dataModel: DataModel
    
    var body: some View {
        VStack {
            Text("Summary Statistics").font(.title)
            HStack {
                VStack(alignment: .leading) {
                    Text("Resistance:").font(.title2)
                    Text("µ = \(dataModel.resistanceStatistics.mean) Ω")
                    Text("σ = \(dataModel.resistanceStatistics.standardDeviation) Ω")
                    Text("min = \(dataModel.resistanceStatistics.min) Ω")
                    Text("max = \(dataModel.resistanceStatistics.max) Ω")
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("Resistivity:").font(.title2)
                    Text("µ = 9.324 Ω·cm")
                    Text("σ = 0.019 Ω·cm")
                    Text("min = 7.575 Ω·cm")
                    Text("max = 11.103 Ω·cm")
                }
            }
        }
    }
}


/*
 #Preview {
     SummaryStatisticsView()
 }
 */



struct SummaryStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel()
        SummaryStatisticsView(dataModel: dataModel)
    }
}

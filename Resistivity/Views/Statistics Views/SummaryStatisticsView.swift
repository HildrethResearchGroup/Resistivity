//
//  SummaryStatisticsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct SummaryStatisticsView: View {
    @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
    @AppStorage("resistivityUnits") var resistivityUnits: ResistivityUnits = .ohm_meters
    @AppStorage("lineResistanceUnits") var lineResistanceUnits: LineResistanceUnits = .ohmPerMeters
    
    @ObservedObject var dataViewModel: DataViewModel
    
    
    var body: some View {
        VStack {
            Text("Summary Statistics").font(.title)
            HStack {
                Spacer()
                StatisticsView(title: "Resistance", units: resistanceUnits, statistics: dataViewModel.resistanceStatistics)
                
                Spacer()
                Divider()
                Spacer()
                
                StatisticsView(title: "Resistivity", units: resistivityUnits, statistics: dataViewModel.resistivityStatistics)
                
                Spacer()
                Divider()
                Spacer()
                
                StatisticsView(title: "Line Resistance", units: lineResistanceUnits, statistics: dataViewModel.lineResistanceStatistics)
                Spacer()
            }
        }
    }
}



// MARK: - Previews
struct SummaryStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        let dataViewModel = DataViewModel(dataModel: DataModel(withInitialData: true))
        SummaryStatisticsView(dataViewModel: dataViewModel)
    }
}

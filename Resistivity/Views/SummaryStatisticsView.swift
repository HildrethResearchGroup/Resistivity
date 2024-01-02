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
    
    
    @ObservedObject var dataViewModel: DataViewModel
    
    
    var body: some View {
        VStack {
            Text("Summary Statistics").font(.title)
            HStack {
                VStack(alignment: .leading) {
                    Text("Resistance:").font(.title2)
                    Text("µ = \(resistanceMean) \(resistanceUnitsDisplay)")
                    Text("σ = \(resistanceSTD) \(resistanceUnitsDisplay)")
                    Text("min = \(resistanceMin) \(resistanceUnitsDisplay)")
                    Text("max = \(resistanceMax) \(resistanceUnitsDisplay)")
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("Resistivity:").font(.title2)
                    Text("µ = \(resistivityMean) \(resistivityUnitsDisplay)")
                    Text("σ = \(resistivitySTD) \(resistivityUnitsDisplay)")
                    Text("min = \(resistivityMin) \(resistivityUnitsDisplay)")
                    Text("max = \(resistivityMax) \(resistivityUnitsDisplay)")
                }
            }
        }
    }
}


// MARK: - Resistance
extension SummaryStatisticsView {
    
    var resistanceUnitsDisplay: String {  return String(resistanceUnits.description)  }
    func scaledResistances(_ valueIn: Double) -> Double {  return valueIn * resistanceUnits.scaleFactor()  }
    
    var resistanceMean: Double { scaledResistances(dataViewModel.resistanceStatistics.mean) }
    var resistanceSTD: Double { scaledResistances(dataViewModel.resistanceStatistics.standardDeviation) }
    var resistanceMin: Double { scaledResistances(dataViewModel.resistanceStatistics.min) }
    var resistanceMax: Double { scaledResistances(dataViewModel.resistanceStatistics.max) }
}


// MARK: - Resistivity
extension SummaryStatisticsView {
    var resistivityUnitsDisplay: String {  return String(resistivityUnits.description)  }
    func scaledResistivity(_ valueIn: Double) -> Double {  return valueIn * resistivityUnits.scaleFactor()  }
    
    var resistivityMean: Double { scaledResistivity(dataViewModel.resistivityStatistics.mean) }
    var resistivitySTD: Double { scaledResistivity(dataViewModel.resistivityStatistics.standardDeviation) }
    var resistivityMin: Double { scaledResistivity(dataViewModel.resistivityStatistics.min) }
    var resistivityMax: Double { scaledResistivity(dataViewModel.resistivityStatistics.max) }
}


// MARK: - Previews
struct SummaryStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        let dataViewModel = DataViewModel(dataModel: DataModel(withInitialData: true))
        SummaryStatisticsView(dataViewModel: dataViewModel)
    }
}

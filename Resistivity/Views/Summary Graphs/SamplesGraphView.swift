//
//  SamplesGraphView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/13/24.
//

import SwiftUI

struct SamplesGraphView: View {
    
    @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
    @AppStorage("resistivityUnits") var resistivityUnits: ResistivityUnits = .ohm_meters
    @AppStorage("lineResistanceUnits") var lineResistanceUnits: LineResistanceUnits = .ohmPerMeters
    
    var samples: [Sample]
    
    @State var selection: Int = 1
    
    var measurementTypes = [1, 2, 3]
    
    var body: some View {
        HSplitView {
            primaryGraph()
                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
            VStack {
                Spacer()
                List(selection: $selection) {
                    GraphSummaryPreview(title: "Resistance", keyPath: \.resistanceStatistics, units: resistanceUnits, samples: samples)
                        .tag(1)
                        .padding()
                        .listRowSeparator(.hidden)
                        .background(in: RoundedRectangle(cornerRadius: 6.0))
                    
                    GraphSummaryPreview(title: "Resistivity", keyPath: \.resistivityStatistics, units: resistivityUnits, samples: samples)
                        .tag(2)
                        .padding(.vertical)
                        .listRowSeparator(.hidden)
                        .background(in: RoundedRectangle(cornerRadius: 6.0))
                    
                    GraphSummaryPreview(title: "Line Resistance", keyPath: \.lineResistanceStatistics, units: lineResistanceUnits, samples: samples)
                        .tag(3)
                        .padding(.vertical)
                        .listRowSeparator(.hidden)
                        .background(in: RoundedRectangle(cornerRadius: 6.0))
                }
                Spacer()
            }
            .frame(width: 250)
            .frame(minHeight: 300, maxHeight: .infinity)
        }
        .onChange(of: selection) {
            print("Selection = \(selection)")
        }
    }
    
    
    
    @ViewBuilder
    func primaryGraph() -> some View {
        switch selection {
        case 1: GraphSummaryView(title: "Resistance", keyPath: \.resistanceStatistics, units: resistanceUnits, samples: samples)
        case 2: GraphSummaryView(title: "Resistivity", keyPath: \.resistivityStatistics, units: resistivityUnits, samples: samples)
        case 3: GraphSummaryView(title: "Line Resistance", keyPath: \.lineResistanceStatistics, units: lineResistanceUnits, samples: samples)
        default: GraphSummaryView(title: "Resistance", keyPath: \.resistanceStatistics, units: resistanceUnits, samples: samples)
        }
    }
}


// MARK: - Previews
struct SamplesGraphView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        SamplesGraphView(samples: dataViewModel.filteredSamples)
    }
}

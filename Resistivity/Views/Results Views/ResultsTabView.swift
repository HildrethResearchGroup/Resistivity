//
//  ResultsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct ResultsTabView: View {
    
    @ObservedObject var dataViewModel: DataViewModel
    @EnvironmentObject var appController: AppController
    
    @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
    
    var body: some View {
        TabView {
            ResultsTableView(measurements: dataViewModel.measurements, selectionManager: appController.selectionManager, order: $dataViewModel.order, searchString: $dataViewModel.search)
                .background(.white)
                .tabItem { Text("􀏣")
                        .help("Table view of raw data")
                }
            
            MeasurementsGraphView(measurements: dataViewModel.measurements)
                .background(.white)
                //.monospaced()
                .tabItem { Text("􁂥")
                        .help("Graph view of resistance data")
                }
            
            SamplesGraphView(samples: dataViewModel.filteredSamples)
                .background(.white)
                .tabItem { Text("μ")
                        .help("Graph view of summary data")
                }
                
        }
        .frame(minWidth: 500, maxWidth: .infinity)
    }
}


struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        ResultsTabView(dataViewModel: dataViewModel)
    }
}


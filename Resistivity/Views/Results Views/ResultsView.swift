//
//  ResultsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct ResultsView: View {
    
    @ObservedObject var dataViewModel: DataViewModel
    @EnvironmentObject var appController: AppController
    
    var body: some View {
        TabView {
            ResultsTableView(measurements: dataViewModel.measurements, selectionManager: appController.selectionManager, order: $dataViewModel.order, searchString: $dataViewModel.search)
                .background(.white)
                .tabItem { Text("􀏣")
                        .help("Table view of raw data")
                }
                
            ResultsGraphView(measurements: dataViewModel.measurements)
                .background(.white)
                .tabItem { Text("􁂥")
                        .help("Graph view of resistance data")
                }
            ResultsSummaryGraphView(samples: dataViewModel.dataModel.samples)
                .background(.white)
                .tabItem { Text("μ")
                        .help("Graph view of summary data")
                }
                
        }
    }
}


struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        ResultsView(dataViewModel: dataViewModel)
    }
}


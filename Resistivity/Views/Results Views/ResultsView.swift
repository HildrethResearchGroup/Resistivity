//
//  ResultsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct ResultsView: View {
    
    @ObservedObject var dataViewModel: DataViewModel
    
    var body: some View {
        TabView {
            ResultsTableView(measurements: dataViewModel.measurements, order: $dataViewModel.order, searchString: $dataViewModel.search)
                .background(.white)
                .tabItem { Text("􀏣") }
            ResultsGraphView(measurements: dataViewModel.measurements)
                .background(.white)
                .tabItem { Text("􁂥") }
                .onAppear() {
                    
                }
            Text("Mean")
                .background(.white)
                .tabItem { Text("μ") }
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


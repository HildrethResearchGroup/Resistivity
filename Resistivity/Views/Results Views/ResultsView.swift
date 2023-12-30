//
//  ResultsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct ResultsView: View {
    
    @ObservedObject var dataModel: DataModel
    
    var body: some View {
        TabView {
            ResultsTableView(measurements: dataModel.sortedAndFilteredMeasurements, order: $dataModel.order, searchString: $dataModel.search)
                .background(.white)
                .tabItem { Text("􀏣") }
            ResultsGraphView(measurements: dataModel.sortedAndFilteredMeasurements)
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
        let dataModel = DataModel()
        ResultsView(dataModel: dataModel)
    }
}


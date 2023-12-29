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
            VStack {
                ResultsTableView(measurements: dataModel.sortedMeasurements, order: $dataModel.order, searchString: $dataModel.search)
            }.tabItem { Text("􀏣") }
            VStack {
                ResultsGraphView(measurements: dataModel.sortedMeasurements)
            }.tabItem { Text("􁂥") }
            VStack {
                Text("Mean")
            }.tabItem { Text("μ") }
        }
    }
}


struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel()
        ResultsView(dataModel: dataModel)
    }
}


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
                ResultsTableView(measurements: $dataModel.flattendMeasurements)
            }.tabItem { Text("􀏣") }
            VStack {
                Text("Graphs")
            }.tabItem { Text("􁂥") }
            VStack {
                Text("Mean")
            }.tabItem { Text("μ") }
        }
    }
}

/*
 #Preview {

     ResultsView(dataModel: DataModel())
 }
 */


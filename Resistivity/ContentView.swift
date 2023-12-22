//
//  ContentView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appController: AppController
    
    var body: some View {
        HSplitView {
            VStack {
                MeasurementConfiguratorView()
                Divider()
                SummaryStatisticsView()
                Divider()
                SampleInformationView(sampleSettings: appController.sampleSettings, locationSettings: appController.locationSettings)
                Divider()
            }
            .frame(minWidth: 300, maxWidth: 500)
            VStack {
                ResultsView(dataModel: appController.dataModel)
            }.frame(minWidth: 400, maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

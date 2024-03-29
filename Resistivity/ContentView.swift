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
                
                SampleInformationView(sampleSettings: appController.sampleSettings, locationSettings: appController.locationSettings)
                
                Divider()
                
                MeasurementConfiguratorView()
                
                Divider()
                
                SummaryStatisticsView(dataViewModel: appController.dataViewModel)
                
                Divider()
            }
            .frame(width: 550)
            VStack {
                ResultsTabView(dataViewModel: appController.dataViewModel)
                    .frame(minWidth: 400, maxWidth: .infinity)
            }
            .frame(minWidth: 400, maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

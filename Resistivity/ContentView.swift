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
                VStack {
                    HStack {
                        Text("Instrument Info: \(appController.information)")
                        Button("􀅈") {
                            appController.getInformation()
                        }
                    }
                    HStack {
                        Text("Last Measurement: \(appController.lastMeasurement)")
                        Button("􀅈") {
                            appController.measureResistance()
                        }
                    }
                }
               
                
                Divider()
                MeasurementConfiguratorView()
                Divider()
                SummaryStatisticsView()
                Divider()
                SampleInformationView()
                Divider()
            }
            .frame(minWidth: 300, maxWidth: 500)
            VStack {
                ResultsView()
            }.frame(minWidth: 400, maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HSplitView {
            VStack {
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

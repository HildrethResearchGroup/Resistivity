//
//  MeasurementConfiguratorView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct MeasurementConfiguratorView: View {
    @EnvironmentObject var appController: AppController
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Measurement Settings").font(.title)
            HStack {
                Text("# of Measurements:")
                TextField("# of Measurements", value: $appController.measurementSettings.numberOfMeasurements, format: .number)
                    .help("# of measurements to take at a time.")
                    .frame(width: 100)
            }
            Divider()
                .frame(width: 400)
            HStack(alignment: .top) {
                ResistivitySettingsView(settings: appController.resistivitySettings)
                Divider()
                LineResistanceSettingsView(settings: appController.lineResistanceSettings)
            }.padding()

        }
        
                
        
    }
}

struct MeasurementConfiguratorView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementConfiguratorView()
            .environmentObject(AppController())
    }
}

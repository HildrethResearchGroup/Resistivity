//
//  MeasurementConfiguratorView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct MeasurementConfiguratorView: View {
    var body: some View {
        VStack {
            Text("Measurement Settings").font(.title)
            HStack {
                Text("Picker: Delay Type")
                Text("TextField: Delay Time")
                Text("Picker: Time Units")
            }.padding()
            HStack {
                Text("Number of measurements:")
                Text("TextField: # of measurements")
            }.padding()
            HStack {
                Text("Toggle: Calculate Resistivity")
                Text("Button: Configure Resistivity")
            }.padding()
        }
        
        
    }
}

#Preview {
    MeasurementConfiguratorView()
}
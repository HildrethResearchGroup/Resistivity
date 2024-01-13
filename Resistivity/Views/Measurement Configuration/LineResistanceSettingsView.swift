//
//  LineResistanceSettingsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/23/23.
//

import SwiftUI

struct LineResistanceSettingsView: View {
    @ObservedObject var settings: LineResistanceSettings
    
    var body: some View {
        VStack(alignment: .center) {
            Toggle("Calculate Line Resistivity", isOn: $settings.shouldCalculateLineResistance)
                .help(settings.shouldCalculateLineResistance ? "Line resistance will be calculated.  Toggle to turn off calculations" : "Line resistance won't be calculated.  Toggle to turn on calculations")
            HStack {
                Text("Gap")
                TextField("Gap", value: $settings.voltageSensingGap, format: .number)
                    .help("Gap between voltage sensing probes [m]")
                    .disabled(!settings.shouldCalculateLineResistance)
                Picker("", selection: $settings.gapUnits) {
                    ForEach(LengthUnits.allCases) {
                        Text($0.description)
                    }
                }.help("Select Units for Gap Length.\n Note: This is saved when the measurement is taken and is not dynamically updated")
            }
            
        }
    }
}

#Preview {
    LineResistanceSettingsView(settings: LineResistanceSettings())
}

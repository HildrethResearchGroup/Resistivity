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
        Form() {
            Toggle("Calculate Line Resistivity", isOn: $settings.shouldCalculateLineResistance)
                .help(settings.shouldCalculateLineResistance ? "Line resistance will be calculated.  Toggle to turn off calculations" : "Line resistance won't be calculated.  Toggle to turn on calculations")
            TextField("Gap [m]", value: $settings.voltageSensingGap, format: .number)
                .help("Gap between voltage sensing probes [m]")
                .disabled(!settings.shouldCalculateLineResistance)
        }
    }
}

#Preview {
    LineResistanceSettingsView(settings: LineResistanceSettings())
}

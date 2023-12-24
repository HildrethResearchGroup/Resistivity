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
            TextField("Gap", value: $settings.voltageSensingGap, format: .number)
                .help("Gap between voltage sensing probes [m]")
                .disabled(!settings.shouldCalculateLineResistance)
        }
    }
}

#Preview {
    LineResistanceSettingsView(settings: LineResistanceSettings())
}

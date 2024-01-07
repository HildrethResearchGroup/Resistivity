//
//  ResistivitySettingsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/23/23.
//

import SwiftUI

struct ResistivitySettingsView: View {
    @ObservedObject var settings: ResistivityMeasurementSettings
    
    
    var body: some View {
        Form {
            Toggle("Calculate Resistivity", isOn: $settings.shouldCalculateResistivity)
                .help(settings.shouldCalculateResistivity ? "Resistivity will be calculated.  Toggle to turn off calculations" : "Resistivity won't be calculated.  Toggle to turn on calculations")
            TextField("Thickness", value: $settings.thickness, format: .number)
                .help("Thickness [m]")
                .disabled(!settings.shouldCalculateResistivity)
            TextField("TCF", value: $settings.thicknessCorrectionFactor, format: .number)
                .help("Thickness Correction Factor")
                .disabled(!settings.shouldCalculateResistivity)
            TextField("FWCF", value: $settings.finiteWidthCorrectionFactor, format: .number)
                .help("Finite Width Correction Factor")
                .disabled(!settings.shouldCalculateResistivity)
        }
    }
}

#Preview {
    ResistivitySettingsView(settings: ResistivityMeasurementSettings())
}

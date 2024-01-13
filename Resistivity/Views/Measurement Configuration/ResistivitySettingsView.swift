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
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Toggle("Calculate Resistivity", isOn: $settings.shouldCalculateResistivity)
                    .help(settings.shouldCalculateResistivity ? "Resistivity will be calculated.  Toggle to turn off calculations" : "Resistivity won't be calculated.  Toggle to turn on calculations")
                Spacer()
                    
            }
            HStack {
                Text("Thickness")
                    .frame(width: 70, alignment: .leading)
                TextField("Thickness", value: $settings.thickness, format: .number)
                    .help("Thickness of the sample in \(settings.thicknessUnits.description)")
                    .disabled(!settings.shouldCalculateResistivity)
                    .frame(width: 70)
                Picker("", selection: $settings.thicknessUnits) {
                    ForEach(LengthUnits.allCases) {
                        Text($0.description)
                    }
                    
                }
                .disabled(!settings.shouldCalculateResistivity)
                .help("Select Units for Thickness.\n Note: This is saved when the measurement is taken and is not dynamically updated")
            }
            HStack {
                Text("TCF")
                    .frame(width: 70, alignment: .leading)
                TextField("TCF", value: $settings.thicknessCorrectionFactor, format: .number)
                    .help("Thickness Correction Factor")
                    .disabled(!settings.shouldCalculateResistivity)
                    .frame(width: 70)
            }
            HStack {
                Text("FWCF")
                    .frame(width: 70, alignment: .leading)
                TextField("FWCF", value: $settings.finiteWidthCorrectionFactor, format: .number)
                    .help("Finite Width Correction Factor")
                    .disabled(!settings.shouldCalculateResistivity)
                    .frame(width: 70)
            }
            
        }
    }
}

#Preview {
    ResistivitySettingsView(settings: ResistivityMeasurementSettings())
}

//
//  Button_lineResistanceUnits.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/11/24.
//

import SwiftUI

struct Button_lineResistanceUnits: View {
    @AppStorage("lineResistanceUnits") var lineResistanceUnits: LineResistanceUnits = .ohmPerMeters
    
    var body: some View {
        Picker("Ω/m Units", selection: $lineResistanceUnits) {
            ForEach(LineResistanceUnits.allCases) { units in
                Text(String(describing: units))
            }
        }
        .help("Select Line Resistance Units")
    }
}

#Preview {
    Button_lineResistanceUnits()
}

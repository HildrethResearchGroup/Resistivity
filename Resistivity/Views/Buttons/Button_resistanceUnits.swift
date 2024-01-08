//
//  Button_resistanceUnits.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/8/24.
//

import SwiftUI

struct Button_resistanceUnits: View {
    @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
    
    var body: some View {
        Picker("Ω Units", selection: $resistanceUnits) {
            ForEach(ResistanceUnits.allCases) { units in
                Text(String(describing: units))
            }
        }
        .help("Select Resistance Units")
    }
}

#Preview {
    Button_resistanceUnits()
}



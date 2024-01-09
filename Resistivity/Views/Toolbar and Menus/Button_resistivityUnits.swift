//
//  Button_resistivityUnits.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/8/24.
//

import SwiftUI

struct Button_resistivityUnits: View {
    @AppStorage("resistivityUnits") var resistivityUnits: ResistivityUnits = .ohm_meters
    
    var body: some View {
        Picker("Ω-m Units", selection: $resistivityUnits) {
            ForEach(ResistivityUnits.allCases) { units in
                Text(String(describing: units))
            }
        }
        .help("Select Resistivity Units")
    }
}

#Preview {
    Button_resistivityUnits()
}

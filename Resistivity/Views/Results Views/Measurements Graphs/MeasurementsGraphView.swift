//
//  MeasurementsGraphView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/12/24.
//

import SwiftUI

struct MeasurementsGraphView: View {
    
    @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
    @AppStorage("resistivityUnits") var resistivityUnits: ResistivityUnits = .ohm_meters
    @AppStorage("lineResistanceUnits") var lineResistanceUnits: LineResistanceUnits = .ohmPerMeters
    
    var measurements: [Measurement]
    
    @State var selection: Int = 1
    
    var measurementTypes = [1, 2, 3]
    
    var body: some View {
        HSplitView {
            primaryGraph()
                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
            VStack {
                Spacer()
                List(selection: $selection) {
                    GraphPreview(title: "Resistance", keyPath: \.resistance, units: resistanceUnits, measurements: measurements)
                        .tag(1)
                        .padding(.vertical)
                        .listRowSeparator(.hidden)
                    GraphPreview(title: "Resistivity", keyPath: \.resistivity, units: resistivityUnits, measurements: measurements)
                        .tag(2)
                        .padding(.vertical)
                        .listRowSeparator(.hidden)
                    GraphPreview(title: "Line Resistance", keyPath: \.lineResistance, units: lineResistanceUnits, measurements: measurements)
                        .tag(3)
                        .padding(.vertical)
                        .listRowSeparator(.hidden)
                }
                Spacer()
            }
            .frame(width: 250)
            .frame(minHeight: 300, maxHeight: .infinity)
        }
        .onChange(of: selection) {
            print("Selection = \(selection)")
        }
    }
    
    @ViewBuilder
    func primaryGraph() -> some View {
        switch selection {
        case 1: GraphView(title: "Resistance", keyPath: \.resistance, units: resistanceUnits, measurements: measurements)
        case 2: GraphView(title: "Resistivity", keyPath: \.resistivity, units: resistivityUnits, measurements: measurements)
        case 3: GraphView(title: "Line Resistance", keyPath: \.lineResistance, units: lineResistanceUnits, measurements: measurements)
        default: GraphView(title: "Resistance", keyPath: \.resistance, units: resistanceUnits, measurements: measurements)
        }
    }
}

extension MeasurementsGraphView {
    enum FocusData {
        case resistance
        case resistivity
        case lineResistance
    }
}



/*
 #Preview {
     MeasurementsGraphView()
 }
 */


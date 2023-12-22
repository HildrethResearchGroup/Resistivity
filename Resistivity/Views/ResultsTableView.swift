//
//  ResultsTab.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/23/23.
//

import Foundation
import SwiftUI

struct ResultsTableView: View {
    
    @Binding var measurements: [Measurement]
    
    var body: some View {
        Table(measurements) {
            TableColumn("Global #") {Text("\($0.globalMeasurementNumber)")}
            TableColumn("Sample Name", value: \.sampleInfo.name)
            TableColumn("Sample #") {Text("\($0.sampleInfo.sampleNumber)")}
            TableColumn("Location", value: \.locationInfo.name)
            TableColumn("Location #") {Text("\($0.locationMeasurementNumber)")}
            TableColumn("Measurement #") {Text("\($0.globalMeasurementNumber)")}
            TableColumn("Resistance") {Text("\($0.resistance)")}
        }

    }
}

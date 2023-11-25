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
            TableColumn("Sample #") {Text("\($0.sampleMeasurementNumber)")}
            TableColumn("Location #") {Text("\($0.locationMeasurementNumber)")}
            TableColumn("Measurement #") {Text("\($0.localMeasurementNumber)")}
            TableColumn("Resistance") {Text("\($0.resistance)")}
            TableColumn("Sample Name", value: \.sampleInfo.name)
            TableColumn("Location", value: \.location.name)
        }

    }
}

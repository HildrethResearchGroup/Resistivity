//
//  ResultsTab.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/23/23.
//

import Foundation
import SwiftUI

struct ResultsTableView: View {
    
    @State private var order: [KeyPathComparator<Measurement>] = [
               .init(\.globalMeasurementNumber, order: SortOrder.forward)
           ]
    
    @Binding var measurements: [Measurement]
    
    var body: some View {
        Table(measurements, sortOrder: $order) {
            TableColumn("Measurement #") {Text("\($0.globalMeasurementNumber)")}
            TableColumn("Resistance") {Text("\($0.resistance)")}
            TableColumn("Sample Name", value: \.sampleInfo.name)
            TableColumn("Sample #") {Text("\($0.sampleInfo.sampleNumber)")}
            TableColumn("Loc. Meas. #", value: \.sampleInfo.measurementNumber) { Text("\($0.sampleInfo.measurementNumber)")   }
            TableColumn("Location", value: \.locationInfo.name)
            TableColumn("Location #") {Text("\($0.locationInfo.locationNumber)")}
            TableColumn("Loc. Meas. #", value: \.locationInfo.measurementNumber) { Text("\($0.locationInfo.measurementNumber)")   }
        }

    }
}

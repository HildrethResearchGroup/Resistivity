//
//  ResultsTab.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/23/23.
//

import Foundation
import SwiftUI

struct ResultsTableView: View {
    
    @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
    
    var measurements: [Measurement]
    
    @Binding var order: [KeyPathComparator<Measurement>]
    @Binding var searchString: String
    
    var body: some View {
        Table(measurements, sortOrder: $order) {
            TableColumn("Measurement #") {Text("\($0.globalMeasurementNumber)")}
            TableColumn("Resistance \(resistanceUnitsDisplay)", value: \.resistance) { Text("\($0.scaledResistance(resistanceUnits))") }
            TableColumn("Sample Name", value: \.sampleInfo.name)
            TableColumn("Location", value: \.locationInfo.name)
            TableColumn("SampleID", value: \.sampleID)
        }
        .searchable(text: $searchString)
        .background(.white)
        .padding()

    }
    
    var resistanceUnitsDisplay: String { "[" + String(resistanceUnits.description) + "]" }
    
}


// MARK: - Previews
struct ResultsTableView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        ResultsTableView(measurements: dataModel.flattendMeasurements, order: .constant(dataModel.order), searchString: .constant(dataModel.search))
    }
}

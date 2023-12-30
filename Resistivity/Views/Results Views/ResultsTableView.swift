//
//  ResultsTab.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/23/23.
//

import Foundation
import SwiftUI

struct ResultsTableView: View {
    
    var measurements: [Measurement]
    @Binding var order: [KeyPathComparator<Measurement>]
    @Binding var searchString: String
    
    var body: some View {
        Table(measurements, sortOrder: $order) {
            TableColumn("Measurement #") {Text("\($0.globalMeasurementNumber)")}
            TableColumn("Resistance", value: \.resistance) {Text("\($0.resistance)")}
            TableColumn("Sample Name", value: \.sampleInfo.name)
            TableColumn("Location", value: \.locationInfo.name)
            TableColumn("SampleID", value: \.sampleID)
        }
        .searchable(text: $searchString)
        .background(.white)
        .padding()

    }
}


struct ResultsTableView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        ResultsTableView(measurements: dataModel.flattendMeasurements, order: .constant(dataModel.order), searchString: .constant(dataModel.search))
    }
}

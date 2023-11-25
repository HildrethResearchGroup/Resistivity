//
//  ResultsTab.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/23/23.
//

import Foundation
import SwiftUI

struct ResultsTableView: View {
    
    var dataModel: DataModel
    
    var body: some View {
        Table(dataModel.flattendMeasurements) {
            TableColumn("Identifier") {Text("\($0.id)")}
        }

    }
}

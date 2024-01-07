//
//  DeleteMeasurementsButton.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/4/24.
//

import SwiftUI

struct DeleteMeasurementsButton: View {
    var selectionManager: SelectionManager
    var body: some View {
        Button("Delete") {
            selectionManager.deleteSelectedMeasurements()
        }
        .keyboardShortcut(.delete)
        .help("Delected the \(selectionManager.numberOfSelectedMeasurements) selected measurements.")
    }
}



// MARK: - Previews
struct DeleteMeasurementsButton_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        let selectionManager = SelectionManager(dataModel: dataModel)
        DeleteMeasurementsButton(selectionManager: selectionManager)
    }
}

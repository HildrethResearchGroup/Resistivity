//
//  CopyMeasurementsButton.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/4/24.
//

import SwiftUI

struct CopyMeasurementsButton: View {
    var selectionManager: SelectionManager
    var body: some View {
        Button("Copy") {
            selectionManager.postCopyMeasurements()
        }
        .keyboardShortcut("c", modifiers: /*@START_MENU_TOKEN@*/.command/*@END_MENU_TOKEN@*/)
        .help("Copy the \(selectionManager.numberOfSelectedMeasurements) selected measurements.")
    }
}

// MARK: - Previews
struct CopyMeasurementsButton_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        let selectionManager = SelectionManager(dataViewModel: dataViewModel)
        CopyMeasurementsButton(selectionManager: selectionManager)
    }
}

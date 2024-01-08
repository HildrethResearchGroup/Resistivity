//
//  Button_clearAll.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/8/24.
//

import SwiftUI

struct Button_clearAll: View {
    
    var selectionManager: SelectionManager
    
    var body: some View {
        Button("Clear All") {
            selectionManager.clearMeasurementsSelection()
        }
        .keyboardShortcut(.escape, modifiers: .command)
        .help("Clear all measurements")
    }
}


// MARK: - Previews
struct Button_clearAll_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        let selectionManager = SelectionManager(dataViewModel: dataViewModel)
        Button_clearAll(selectionManager: selectionManager)
    }
}

//
//  Button_selectAll.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/8/24.
//

import SwiftUI

struct Button_selectAll: View {
    
    var selectionManager: SelectionManager
    
    var body: some View {
        Button("Select All") {
            selectionManager.selectAllMeasurements()
        }
        .keyboardShortcut("a", modifiers: .command)
        .help("Select all measurements")
    }
}


// MARK: - Previews
struct Button_selectAll_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        let selectionManager = SelectionManager(dataViewModel: dataViewModel)
        Button_selectAll(selectionManager: selectionManager)
    }
}

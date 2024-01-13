//
//  ResistivityApp_menuItems.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/8/24.
//

import SwiftUI

extension ResistivityApp {
    @CommandsBuilder
    func menuItems() -> some Commands {
        CommandGroup(before: .saveItem) {
            Button_export(appController: appController)
        }
        CommandGroup(replacing: .pasteboard) {
            CopyMeasurementsButton(selectionManager: appController.selectionManager)
        }
        CommandGroup(after: .pasteboard) {
            DeleteMeasurementsButton(selectionManager: appController.selectionManager)
        }
        CommandGroup(after: .pasteboard) {
            Divider()
            Button_selectAll(selectionManager: appController.selectionManager)
            Button_clearAll(selectionManager: appController.selectionManager)
        }
    }
}

//
//  ResistivityApp_toolbarItems.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/8/24.
//

import SwiftUI


extension ResistivityApp {
    @ToolbarContentBuilder
    var toolbarItems: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            Button_resistanceUnits()
            Button_resistivityUnits()
            Button_measureResistanceWithNanovoltmeter(appController: appController)
            Button_connectToNanovoltmeter(appController: appController)
        }
    }
}

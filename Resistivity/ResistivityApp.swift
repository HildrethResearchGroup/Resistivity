//
//  ResistivityApp.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import SwiftUI

@main
struct ResistivityApp: App {
    @NSApplicationDelegateAdaptor(ResistivityAppDelegate.self) var appDelegate
    @StateObject var appController = AppController()
    
    @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
    @AppStorage("resistivityUnits") var resistivityUnits: ResistivityUnits = .ohm_meters
    @AppStorage("lineResistanceUnits") var lineResistanceUnits: LineResistanceUnits = .ohmPerMeters
    
    @State var presentConnectionAlert = false
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 400, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
                .environmentObject(appController)
                .toolbar() {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button_resistanceUnits()
                        Button_resistivityUnits()
                        Button_measureResistanceWithNanovoltmeter(appController: appController)
                        Button_connectToNanovoltmeter(appController: appController)
                    }
                }
        }
        .commands {
            menuItems() // See ResistivityApp_menuItems
        }
        
        Settings {
            PreferencesView()
        }
    }
}

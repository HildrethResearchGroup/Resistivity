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
    
    /*
     @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
     @AppStorage("resistivityUnits") var resistivityUnits: ResistivityUnits = .ohm_meters
     @AppStorage("lineResistanceUnits") var lineResistanceUnits: LineResistanceUnits = .ohmPerMeters
     */
    
    
    @State var presentConnectionAlert = false
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 400, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
                .environmentObject(appController)
                .toolbar() {
                    toolbarItems
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

//
//  ResistivityApp.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import SwiftUI

@main
struct ResistivityApp: App {
    @StateObject var appController = AppController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 100, maxWidth: .infinity)
                .environmentObject(appController)
                .toolbar {
                    Button("􀋥") {
                        connect()
                    }
                }
        }
        
        Settings {
            PreferencesView()
        }
    }
    
    func connect() {
        do {
            try appController.collectionController.createOhmMeter()
        } catch {
            print("Could Not Create Ohm Meter")
            print(error)
        }
    }
    
    
}



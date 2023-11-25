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
                    Button_measureResistanceWithNanovoltmeter()
                    Button_connectToNanoVoltmeter()
                }
        }
        
        Settings {
            PreferencesView()
        }
    }
    
    
    
    
}


// MARK: - Toolbar Nanovoltmeter Connect Button Implementation
extension ResistivityApp {
    
    func voltmeterColor() -> Color {
        switch appController.nanoVoltMeterStatus {
        case .disconnected:
            return .red
        case .connecting:
            return .yellow
        case .connected:
            return .green
        case .measuring:
            return .blue
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
    
    @ViewBuilder
    func Button_connectToNanoVoltmeter() -> some View {
        Button(action: connect) {
            Text("􀋦")
                .foregroundStyle(voltmeterColor())
                .padding([.leading, .trailing], 5.0)
        }
    }
}

// MARK: - Toolbar Nanovoltmeter Measure Button Implementation
extension ResistivityApp {
    @ViewBuilder
    func Button_measureResistanceWithNanovoltmeter() -> some View {
        Button(action: measureResistanceWithNanovoltmeter) {
            Text("􀊄")
                .foregroundStyle(measureResistanceButtonColor)
                .disabled(measureResistanceWithNanovoltmeterIsDisabled)
                .padding([.leading, .trailing], 5.0)
        }
    }
    
    func measureResistanceWithNanovoltmeter() {
        appController.measureResistance()
    }
    
    var measureResistanceWithNanovoltmeterIsDisabled: Bool {
        get {
           
            let status = appController.nanoVoltMeterStatus
            
            switch status {
            case .disconnected: return true
            case .connecting: return true
            case .measuring: return true
            case .connected: return false
            }
        }
    }
    
    var measureResistanceButtonColor: Color {
        get {
            switch appController.nanoVoltMeterStatus {
            case .measuring: return .yellow
            case .disconnected: return .gray
            case .connecting: return .gray
            case .connected: return .green
            }
        }
    }
}

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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 100, maxWidth: .infinity)
                .environmentObject(appController)
                .toolbar() {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Picker("Ω Units", selection: $resistanceUnits) {
                            ForEach(ResistanceUnits.allCases) { units in
                                Text(String(describing: units))
                                
                            }
                        }
                        Picker("Ω-m Units", selection: $resistivityUnits) {
                            ForEach(ResistivityUnits.allCases) { units in
                                Text(String(describing: units))
                            }
                        }
                        Button_measureResistanceWithNanovoltmeter()
                        Button_connectToNanoVoltmeter()
                    }
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
            case .measuring: return .blue
            case .disconnected: return .red
            case .connecting: return .yellow
            case .connected: return .green
            }
        }
    }
}

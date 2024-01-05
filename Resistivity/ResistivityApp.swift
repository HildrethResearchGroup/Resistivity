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
                        Button_resistanceUnits()
                        Button_resistivityUnits()
                        Button_measureResistanceWithNanovoltmeter().disabled(measureResistanceWithNanovoltmeterIsDisabled)
                        Button_connectToNanoVoltmeter()
                    }
                }
        }
        .commands {
            CommandGroup(before: .saveItem) {
                Button_export()
            }
            CommandGroup(replacing: .pasteboard) {
                CopyMeasurementsButton(selectionManager: appController.selectionManager)
            }
            CommandGroup(after: .pasteboard) {
                DeleteMeasurementsButton(selectionManager: appController.selectionManager)
            }
            CommandGroup(after: .pasteboard) {
                Divider()
                Button("Clear Selection") {
                    appController.selectionManager.clearMeasurementsSelection()
                }
                .keyboardShortcut(.escape, modifiers: .command)
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


// MARK: - Toolbar Nanovoltmeter Measure Button
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
            case .disconnected: return .gray
            case .connecting: return .gray
            case .connected: return .green
            }
        }
    }
}


// MARK: - Toolbar Units Picker Buttons
extension ResistivityApp {
    
    @ViewBuilder
    func Button_resistivityUnits() -> some View {
        Picker("Ω-m Units", selection: $resistivityUnits) {
            ForEach(ResistivityUnits.allCases) { units in
                Text(String(describing: units))
            }
        }
    }
    
    
    @ViewBuilder
    func Button_resistanceUnits() -> some View {
        Picker("Ω Units", selection: $resistanceUnits) {
            ForEach(ResistanceUnits.allCases) { units in
                Text(String(describing: units))
            }
        }
    }
}


// MARK: - File Export
extension ResistivityApp {
    func exportFileLocation() -> URL? {
        let panel = NSSavePanel()
        panel.title = "Export"
        panel.allowedContentTypes = [.commaSeparatedText]
        panel.nameFieldLabel = "Base File Name"
        panel.canCreateDirectories = true
        if panel.runModal() == .OK {
            return panel.url
        } else {return nil}
    }
    
    @ViewBuilder
    func Button_export() -> some View {
        Button(action: {
            let exportURL = exportFileLocation()
            do {
                try appController.exportCombinedData(to: exportURL)
            } catch  {
                print(error)
            }
        }, label: {Text("Export Data")})
        .keyboardShortcut("s", modifiers: /*@START_MENU_TOKEN@*/.command/*@END_MENU_TOKEN@*/)
    }
}

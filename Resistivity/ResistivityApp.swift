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
                Button_selectAll()
                Button_clearAll()
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
        Task {
            do {
                try await appController.collectionController.createOhmMeter()
            } catch {
                self.presentConnectionAlert = true
            }
        }
        
    }
    
    @ViewBuilder
    func Button_connectToNanoVoltmeter() -> some View {
        Button(action: connect) {
            Text("􀋦")
                .foregroundStyle(voltmeterColor())
                .padding([.leading, .trailing], 5.0)
        }.help(tip_connectButton())
            .alert("Connection Error", isPresented: $presentConnectionAlert, actions: {
                Button("Close") {presentConnectionAlert = false}
            }, message: {
                Text(connectionAlertMessage())
            })
    }
    
    func tip_connectButton() -> String {
        var tipText = ""
        switch appController.nanoVoltMeterStatus {
        case .connected: tipText = "Connected to: \(appController.information)"
        case .connecting: tipText = "Connecting to Nanovoltmeter"
        case .measuring: tipText = "Measurement in Progress"
        case .disconnected: tipText = "Connect to Nanovoltmeter"
        }
        return tipText
    }
    
    func connectionAlertMessage() -> String {
        
        
        
        if appController.collectionController.ipAddress != nil && appController.collectionController.port != nil {
            let address = appController.collectionController.ipAddress!
            let port = appController.collectionController.port!
            let message = "Could not connect to Nanovoltmeter at: \(address):\(port)).\nPossible solutions:\nCheck network connections & permissions/blockers.  Verify instrument is on, GPID adapter is powered, cables are connected."
            return message
        } else {
            let message = "Could not connect to Nanovoltmeter.\nIP Address or Port Missing.  Update these values in Settings."
            return message
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
                .help(tip_measurementButton)
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
    
    var tip_measurementButton: String {
        switch appController.nanoVoltMeterStatus {
        case .connected: "Take a measurement"
        case .connecting: "Nanovoltmeter connection in progress."
        case .disconnected: "Cannot take a measurement until the Nanovoltmeter is connected"
        case .measuring: "Measurement in progress"
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
        .help("Select Resistivity Units")
    }
    
    
    @ViewBuilder
    func Button_resistanceUnits() -> some View {
        Picker("Ω Units", selection: $resistanceUnits) {
            ForEach(ResistanceUnits.allCases) { units in
                Text(String(describing: units))
            }
        }
        .help("Select Resistance Units")
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
        .help("Export Summary and Raw Data as csv file")
    }
}


// MARK: - Selection Menu Buttons
extension ResistivityApp {
    @ViewBuilder
    func Button_selectAll() -> some View {
        Button("Select All") {
            appController.selectionManager.selectAllMeasurements()
        }
        .keyboardShortcut("a", modifiers: .command)
        .help("Select all measurements")
    }
    
    @ViewBuilder
    func Button_clearAll() -> some View {
        Button("Clear Selection") {
            appController.selectionManager.clearMeasurementsSelection()
        }
        .keyboardShortcut(.escape, modifiers: .command)
        .help("Clear Selection")
    }
}

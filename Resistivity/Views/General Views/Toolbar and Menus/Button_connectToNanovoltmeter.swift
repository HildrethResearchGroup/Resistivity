//
//  Button_connect.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/8/24.
//

import SwiftUI

struct Button_connectToNanovoltmeter: View {
    
    @ObservedObject var appController: AppController
    
    @State var presentConnectionAlert = false
    
    var body: some View {
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
    
    
    func connect() {
        Task {
            do {
                try await appController.collectionController.createOhmMeter()
            } catch {
                self.presentConnectionAlert = true
            }
        }
        
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
            let message = "Could not connect to Nanovoltmeter at: \(address):\(port)).\nPossible solutions:\nCheck network connections & permissions/blockers.\nVerify instrument is on, GPID adapter is powered, cables are connected."
            return message
        } else {
            let message = "Could not connect to Nanovoltmeter.\nIP Address or Port Missing.  Update these values in Settings."
            return message
        }
    }
    
    
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
    
}


struct Button_connect_Previews: PreviewProvider {
    static var previews: some View {
        let appController = AppController()
        Button_connectToNanovoltmeter(appController: appController)
    }
}

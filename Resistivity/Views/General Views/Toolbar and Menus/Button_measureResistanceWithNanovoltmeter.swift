//
//  Button_measureResistanceWithNanovoltmeter.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/8/24.
//

import SwiftUI

struct Button_measureResistanceWithNanovoltmeter: View {
    @ObservedObject var appController: AppController
    
    var body: some View {
        Button(action: measureResistanceWithNanovoltmeter) {
            Text("􀊄")
                .foregroundStyle(measureResistanceButtonColor)
                .disabled(measureResistanceWithNanovoltmeterIsDisabled)
                .padding([.leading, .trailing], 5.0)
                .help(tip_measurementButton)
        }
        .disabled(measureResistanceWithNanovoltmeterIsDisabled)
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



// MARK: - Previews
struct Button_measureResistanceWithNanovoltmeter_Previews: PreviewProvider {
    static var previews: some View {
        let appController = AppController()
        Button_measureResistanceWithNanovoltmeter(appController: appController)
    }
}

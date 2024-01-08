//
//  Button_export.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/8/24.
//

import SwiftUI

struct Button_export: View {
    
    var appController: AppController
    
    var body: some View {
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
}




// MARK: - Previews
struct Button_export_Previews: PreviewProvider {
    static var previews: some View {
        let appController = AppController()
        
        Button_export(appController: appController)
    }
}

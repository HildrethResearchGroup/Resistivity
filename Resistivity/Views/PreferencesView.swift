//
//  PreferencesView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct PreferencesView: View {
    
    @AppStorage("ipAddress") var ipAddress: String = "169.254.1.103"
    @AppStorage("port") var port: Int = 1234
    
    var body: some View {
        HStack(alignment: .center) {
            Text("IP Address:")
            TextField("", text: $ipAddress)
                .padding(.trailing)
            
            Text("Port:")
            TextField("", value: $port, formatter: format)
        }
        .padding()
        
    }
    
    var format: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = false
        formatter.usesGroupingSeparator = false
        
        return formatter
    }
}

#Preview {
    PreferencesView()
}

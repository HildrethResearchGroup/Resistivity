//
//  SampleInformationView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct SampleInformationView: View {
    var body: some View {
        VStack {
            Text("Sample Information")
                .font(.title)
                .padding(.bottom)
            HStack {
                Text("Name:")
                Text("TextField: Name for sample")
            }
            HStack {
                Text("Location:")
                Text("TextField: Measurement Location")
            }
            HStack {
                Text("Measurement Number:")
                Text("Label: Measurement Number")
            }
            
        }.padding()
        
    }
}

#Preview {
    SampleInformationView()
}

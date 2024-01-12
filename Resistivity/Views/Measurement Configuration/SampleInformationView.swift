//
//  SampleInformationView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct SampleInformationView: View {
    
    @ObservedObject var sampleSettings: SampleSettings
    
    @ObservedObject var locationSettings: LocationSettings
    
    var body: some View {
        VStack(alignment: .textFieldAlignmentGuide) {
            Text("Sample Information")
                .font(.title)
                .padding(.bottom)
            HStack () {
                Text("Sample Name:")
                TextField("Sample Name:", text: $sampleSettings.name)
                    .alignmentGuide(.textFieldAlignmentGuide) {context in
                        context[.leading]
                    }
                    .frame(width: 300)
                    .help("What is the Sample's name or ID?  Example:  RSI-S23 - Humidty Tests-50% rh, 100 ˚C, 20 layers")
            }
            HStack {
                Text("Location:")
                TextField("Location:", text: $locationSettings.name)
                    .alignmentGuide(.textFieldAlignmentGuide) {context in
                        context[.leading]
                    }
                    .frame(width: 300)
                    .help("Where on the sample is the measurement being collected?  Examples: Right left corner, center, Line 5, etc.")
                //Text("TextField: Measurement Location")
            }
            
        }.padding()
        
    }
}

#Preview {
    SampleInformationView(sampleSettings: SampleSettings(), 
                          locationSettings: LocationSettings())
    
}

extension HorizontalAlignment {
    private struct TextFieldAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.leading]
        }
    }
    
    static let textFieldAlignmentGuide = HorizontalAlignment(TextFieldAlignment.self)
}

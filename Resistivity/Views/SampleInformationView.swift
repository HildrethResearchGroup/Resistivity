//
//  SampleInformationView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct SampleInformationView: View {
    
    @ObservedObject var dataModel: DataModel
    
    var body: some View {
        VStack(alignment: .textFieldAlignmentGuide) {
            Text("Sample Information")
                .font(.title)
                .padding(.bottom)
            HStack () {
                Text("Sample Name:")
                TextField("Sample Name:", text: $dataModel.currentSampleInfoName)
                    .alignmentGuide(.textFieldAlignmentGuide) {context in
                        context[.leading]
                    }
                    .frame(minWidth: 200, idealWidth: 300, maxWidth: 350)
            }
            HStack {
                Text("Location:")
                TextField("Location:", text: $dataModel.currentLocationInfoName)
                    .alignmentGuide(.textFieldAlignmentGuide) {context in
                        context[.leading]
                    }
                    .frame(minWidth: 200, idealWidth: 300, maxWidth: 350)
                //Text("TextField: Measurement Location")
            }
            HStack {
                Text("Measurement Number:")
                Text("\(dataModel.measurementNumber)")
                    .alignmentGuide(.textFieldAlignmentGuide) {context in
                    context[.leading]
                }
                
            }
            
        }.padding()
        
    }
}

#Preview {
    SampleInformationView(dataModel: DataModel())
}

extension HorizontalAlignment {
    private struct TextFieldAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.leading]
        }
    }
    
    static let textFieldAlignmentGuide = HorizontalAlignment(TextFieldAlignment.self)
}

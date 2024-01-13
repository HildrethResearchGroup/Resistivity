//
//  TabLabel.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct TabLabel: View {
           let imageName: String
           let label: String
           
           var body: some View {
               HStack {
                   Image(systemName: imageName)
                   Text(label)
               }
           }
       }

#Preview {
    TabLabel(imageName: "magnifyingglass", label: "Search")
}

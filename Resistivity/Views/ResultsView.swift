//
//  ResultsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct ResultsView: View {
    var body: some View {
        TabView {
            VStack {
                Text("Raw Results Table")
            }.tabItem { Text("􀏣") }
            VStack {
                Text("Graphs")
            }.tabItem { Text("􁂥") }
            VStack {
                Text("Mean")
            }.tabItem { Text("μ") }
        }
    }
}

#Preview {
    ResultsView()
}

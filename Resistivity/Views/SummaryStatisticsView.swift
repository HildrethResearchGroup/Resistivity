//
//  SummaryStatisticsView.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import SwiftUI

struct SummaryStatisticsView: View {
    var body: some View {
        VStack {
            Text("Summary Statistics").font(.title)
            HStack {
                VStack(alignment: .leading) {
                    Text("Resistance:").font(.title2)
                    Text("µ = 202.681 mΩ")
                    Text("σ = 0.867 mΩ")
                    Text("min = 164.671 mΩ")
                    Text("max = 241.347 mΩ")
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("Resistivity:").font(.title2)
                    Text("µ = 9.324 Ω·cm")
                    Text("σ = 0.019 Ω·cm")
                    Text("min = 7.575 Ω·cm")
                    Text("max = 11.103 Ω·cm")
                }
            }
        }
    }
}


/*
 #Preview {
     SummaryStatisticsView()
 }
 */



struct SummaryStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        
        SummaryStatisticsView()
    }
}

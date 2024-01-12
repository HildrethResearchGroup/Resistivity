//
//  ResultsTab.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/23/23.
//

import Foundation
import SwiftUI

struct ResultsTableView: View {
    
    @AppStorage("resistanceUnits") var resistanceUnits: ResistanceUnits = .ohms
    @AppStorage("resistivityUnits") var resistivityUnits: ResistivityUnits = .ohm_meters
    @AppStorage("lineResistanceUnits") var lineResistanceUnits: LineResistanceUnits = .ohmPerMeters
    
    var measurements: [Measurement]
    
    @ObservedObject var selectionManager: SelectionManager
    @Binding var order: [KeyPathComparator<Measurement>]
    @Binding var searchString: String
    
    
    var body: some View {
        Table(selection: $selectionManager.selection_measurements, sortOrder: $order) {
            TableColumn("Measurement #", value: \.globalMeasurementNumber) {Text("\($0.globalMeasurementNumber)")}
            TableColumn("Resistance \(resistanceUnitsDisplay)", value: \.resistance) { Text(resistance(for:$0)) }
            TableColumn("Resistivity \(resistivityUnitsDisplay)", value: \.resistivity) { Text(resistivity(for:$0)) }
            TableColumn("Line Resistance \(lineResistanceUnitsDisplay)", value: \.lineResistance) { Text(lineResistance(for:$0)) }
            TableColumn("Sample Name", value: \.sampleInfo.name)
            TableColumn("Location", value: \.locationInfo.name)
            TableColumn("SampleID", value: \.sampleID)
        } rows: {
            ForEach(measurements) {
                TableRow($0)
                    .contextMenu() { 
                        CopyMeasurementsButton(selectionManager: selectionManager)
                            .keyboardShortcut("c", modifiers: .command)
                        DeleteMeasurementsButton(selectionManager: selectionManager)
                            .keyboardShortcut(.delete, modifiers: .command)
                    }
            }
        }
        .searchable(text: $searchString)
        .background(.white)
        .padding()

    }
    
    var resistanceUnitsDisplay: String { "[" + String(resistanceUnits.description) + "]" }
    var resistivityUnitsDisplay: String { "[" + String(resistivityUnits.description) + "]" }
    var lineResistanceUnitsDisplay: String { "[" + String(lineResistanceUnits.description) + "]" }
    
    func resistance(for measurement: Measurement) -> String {
        let scaledValue = measurement.scaledResistance(resistanceUnits)
        return formatted(scaledValue)
    }
    
    func resistivity(for measurement: Measurement) -> String {
        let scaledValue = measurement.scaledResistivity(resistivityUnits)
        return formatted(scaledValue)
    }
    
    func lineResistance(for measurement: Measurement) -> String {
        let scaledValue = measurement.scaledLineResistance(lineResistanceUnits)
        return formatted(scaledValue)
    }
    
    
    func formatted(_ valueIn: Double) -> String {
        let number = NSNumber(value: valueIn)
        
        return formatter.string(from: number) ?? "NaN"
    }
    
    private let formatter = NumberFormatter.shortNumber
}



// MARK: - Previews
struct ResultsTableView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DataModel(withInitialData: true)
        let dataViewModel = DataViewModel(dataModel: dataModel)
        let selectionManager = SelectionManager(dataViewModel: dataViewModel)
        ResultsTableView(measurements: dataModel.flattendMeasurements, selectionManager: selectionManager, order: .constant(dataModel.order), searchString: .constant(dataModel.search))
    }
}

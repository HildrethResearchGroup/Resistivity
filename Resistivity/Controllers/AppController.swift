//
//  AppController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 11/21/23.
//

import Foundation

@MainActor
class AppController: ObservableObject {
    @Published var collectionController: DataCollectionController
    var dataModel: DataModel
    
    init() {
        collectionController = DataCollectionController()
        dataModel = DataModel()
    }
    
    @Published var lastMeasurement: Double = 0.0
    
    @Published var information: String = "Nothing Yet"
    
    func measureResistance() {
        Task {
            do {
                let resistance = try await collectionController.measureResistance()
                lastMeasurement = resistance
            } catch {
                print(error)
            }
        }
    }
    
    func getInformation() {
        Task {
            do {
                let info = try await collectionController.getInformation()
                information = info
            } catch {
                print(error)
            }
        }
    }
}

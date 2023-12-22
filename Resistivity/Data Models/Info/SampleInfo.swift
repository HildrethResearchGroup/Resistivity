//
//  SampleInformation.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/12/23.
//

import Foundation

struct SampleInfo {
    var id = UUID()
    var name: String
}

/*
 extension SampleInfo {
     convenience init(_ nameIn: String, withLocationName locationNameIn: String) {
         self.init()
         
         name = nameIn
         
         createNewLocation(withName: locationNameIn)
         
     }
     
     private func isANewLocationNeeded(forName locationNameIn: String) -> Bool {
         guard let location = currentLocation else {
             return true
         }
         
         if location.name != locationNameIn {
             return true
         } else {
             return false
         }
     }
     
     private func createNewLocation(withName locationNameIn: String) {
         let newLocationNumber = locations.count + 1
         
         let newLocation = Location(withName: locationNameIn, withLocationNumber: newLocationNumber)
         
         locations.append(newLocation)
     }
 }
 */


extension SampleInfo: Identifiable, Equatable {
    static func == (lhs: SampleInfo, rhs: SampleInfo) -> Bool {
        lhs.id == rhs.id
    }
}

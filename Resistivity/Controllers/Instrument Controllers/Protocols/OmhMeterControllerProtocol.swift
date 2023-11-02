//
//  NanoVoltMeterController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import Foundation

protocol OmhMeterControllerProtocol: Actor, VISAInstrumentProtocol {
    static var minimumDelay: UInt32 {get}
    
    //var dispatchQueue: DispatchQueue { get }
    
    var returnMode: ReturnMode { get set }
    
    func getResistance() async throws -> Double
    
    func flushData() async
}





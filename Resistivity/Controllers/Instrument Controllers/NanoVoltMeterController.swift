//
//  NanoVoltMeterController.swift
//  Resistivity
//
//  Created by Owen Hildreth on 9/28/23.
//

import Foundation

protocol NanoVoltMeterController: Actor {
    static var minimumDelay: UInt32 {get}
    
    //var dispatchQueue: DispatchQueue { get }
    
    var returnMode: ReturnMode { get set }
    
    init?(ipAddress: String, port: Int) async
    
    func getIdentifier() async throws -> String
    
    func getResistance() async throws -> Double
    
    func flushData() async
}

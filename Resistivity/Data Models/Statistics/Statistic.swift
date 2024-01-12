//
//  Statistic.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/11/24.
//

import Foundation

protocol Statistic {
    var mean: Double { get set }
    var standardDeviation: Double { get set }
    var min: Double { get set }
    var max: Double { get set }
}

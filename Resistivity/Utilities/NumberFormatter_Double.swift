//
//  NumberFormatter_Double.swift
//  Resistivity
//
//  Created by Owen Hildreth on 1/11/24.
//

import Foundation

extension NumberFormatter {
    func string(from valueIn: Double) -> String {
        let number = NSNumber(value: valueIn)
        
        return self.string(from: number) ?? "NaN"
    }
    
    static var shortNumber: NumberFormatter {
        let format = NumberFormatter()
        format.usesSignificantDigits = true
        format.maximumSignificantDigits = 4
        format.minimumSignificantDigits = 2
        
        return format
    }
}

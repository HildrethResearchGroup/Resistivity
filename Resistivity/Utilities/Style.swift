//
//  Style.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation
import AppKit

struct Style {
    var tableNumberFormatter = NumberFormatter()
    
    lazy var monospacedNumberFont: NSFont = {
        let fontSize = NSFont.systemFontSize(for: .regular)
        
        let bodyFontDescriptor = NSFontDescriptor()
            .matchingFontDescriptor(withMandatoryKeys: nil)?
            .withSize(fontSize)
        
        let monospacedNumbersFontDescriptor = bodyFontDescriptor?.addingAttributes([
            NSFontDescriptor.AttributeName.featureSettings:
                [
                    NSFontDescriptor.FeatureKey.typeIdentifier: kNumberSpacingType,
                    NSFontDescriptor.FeatureKey.selectorIdentifier: kMonospacedNumbersSelector
            ]
            ])
        
        let unmonospacedFont = NSFont.systemFont(ofSize: fontSize)
        
        guard let descriptor = monospacedNumbersFontDescriptor else { return unmonospacedFont }
        
        guard let font = NSFont(descriptor: descriptor, size: 0.0) else { return unmonospacedFont }
        
        return font
    }()
    
    
    // MARK: Singleton
    static var `default` = Style()
    
    private init() { }
}


// MARK: Formatting
/*
 extension MeasurementViewController {
     func formatStatisticLabels() {
         meanResistanceLabel.font = Style.default.monospacedNumberFont
         standardDeviationResistanceLabel.font = Style.default.monospacedNumberFont
     }
 }
 */


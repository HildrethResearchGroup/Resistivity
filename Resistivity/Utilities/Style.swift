//
//  Style.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation
import AppKit

/// `Style` is a struct that encapsulates the styling preferences for the Resistivity app.
/// It includes configurations for number formatting and fonts, particularly for displaying
/// monospaced numbers in tables.
struct Style {
    /// `tableNumberFormatter` is a `NumberFormatter` instance used to format numbers in tables.
    /// It can be configured to specify the number style, such as decimal, currency, or percent.
    var tableNumberFormatter = NumberFormatter()
    
    /// `monospacedNumberFont` is a computed property that lazily provides an `NSFont` instance
    /// with monospaced numbers. This font is useful for aligning numbers in tabular data.
    lazy var monospacedNumberFont: NSFont = {
        let fontSize = NSFont.systemFontSize(for: .regular)
        
        // Create a font descriptor for the system font with the specified size.
        let bodyFontDescriptor = NSFontDescriptor()
            .matchingFontDescriptor(withMandatoryKeys: nil)?
            .withSize(fontSize)
        
        // Add attributes to the font descriptor to specify monospaced numbers.
        let monospacedNumbersFontDescriptor = bodyFontDescriptor?.addingAttributes([
            NSFontDescriptor.AttributeName.featureSettings:
                [
                    NSFontDescriptor.FeatureKey.typeIdentifier: kNumberSpacingType,
                    NSFontDescriptor.FeatureKey.selectorIdentifier: kMonospacedNumbersSelector
            ]
            ])
        
        // Fallback font in case the monospaced font cannot be created.
        let unmonospacedFont = NSFont.systemFont(ofSize: fontSize)
        
        // Attempt to create the monospaced font using the descriptor, or return the fallback font.
        guard let descriptor = monospacedNumbersFontDescriptor else { return unmonospacedFont }
        guard let font = NSFont(descriptor: descriptor, size: 0.0) else { return unmonospacedFont }
        
        return font
    }()
    
    // MARK: Singleton
    
    /// `default` is a static instance of `Style`, following the singleton pattern.
    /// This ensures that the same style settings are used throughout the app.
    static var `default` = Style()
    
    /// The private initializer prevents the creation of additional instances of `Style`.
    private init() { }
}

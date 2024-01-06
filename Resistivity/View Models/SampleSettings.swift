//
//  SampleSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation

/// `SampleSettings` is a class that conforms to `ObservableObject` and `Identifiable`.
/// It is used to manage and persist user settings for a sample, such as its name.
class SampleSettings: ObservableObject, Identifiable {
    /// Unique identifier for each `SampleSettings` instance.
    var id = UUID()
    
    /// The name of the sample, which is a published property so that any changes
    /// will update the UI automatically. It is also persisted to `UserDefaults`.
    @Published var name = "" {
        didSet {
            // When the name is changed, it is saved to UserDefaults to persist the change.
            UserDefaults.standard.set(name, forKey: "sampleSettings.name")
        }
    }
    
    /// Initializes a new instance of `SampleSettings`.
    /// It loads the sample name from `UserDefaults` if it exists, or sets it to an empty string.
    init() {
        name = UserDefaults.standard.object(forKey: "sampleSettings.name") as? String ?? ""
    }
    
}

/// Extension of `SampleSettings` to conform to the `Info` protocol.
extension SampleSettings: Info {
    /// The type of output information this class provides.
    typealias Output = SampleInfo
    
    /// Generates a `SampleInfo` object containing the current settings.
    /// - Returns: A `SampleInfo` instance with the current sample name.
    func info() -> SampleInfo {
        let info = SampleInfo(name: self.name)
        
        return info
    }
}

//
//  LocationSettings.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/21/23.
//

import Foundation

/// `LocationSettings` is a class that conforms to `ObservableObject` and `Identifiable` protocols.
/// It is used to manage and persist location settings within the app.
class LocationSettings: ObservableObject, Identifiable {
    /// Unique identifier for each `LocationSettings` instance.
    var id = UUID()
    
    /// The name of the location, which is a published property so that any views using this model
    /// will update when the name changes. The new value is also stored in `UserDefaults` upon change.
    @Published var name = "" {
        didSet { UserDefaults.standard.set(name, forKey: "locationSettings.name") }
    }
    
    /// Initializes a new instance of `LocationSettings`.
    /// It loads the location name from `UserDefaults` if it exists, or initializes it to an empty string.
    init() {
        name = UserDefaults.standard.object(forKey: "locationSettings.name") as? String ?? ""
    }
}

/// Extension of `LocationSettings` to conform to the `Info` protocol.
extension LocationSettings: Info {
    /// The associated type `Output` is set to `LocationInfo`.
    typealias Output = LocationInfo
    
    /// Generates a `LocationInfo` object from the current `LocationSettings`.
    /// - Returns: A `LocationInfo` instance containing the name of the location.
    func info() -> LocationInfo {
        return LocationInfo(name: self.name)
    }
}

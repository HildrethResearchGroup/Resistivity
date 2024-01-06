//
//  Notifications.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation

// MARK: - Measuring

/// Extension of `NSNotification.Name` to define custom notification names related to the measuring process.
extension NSNotification.Name {
    /// Notification name for disabling the measuring functionality.
    static let disableMeasuring = NSNotification.Name("disableMeasuring")
    
    /// Notification name for enabling the measuring functionality.
    static let enableMeasuring = NSNotification.Name("enableMeasuring")
    
    /// Notification name for disabling the stopping functionality.
    static let disableStopping = NSNotification.Name("disableStopping")
    
    /// Notification name for enabling the stopping functionality.
    static let enableStopping = NSNotification.Name("enableStopping")
    
    /// Notification name for indicating that the model has changed.
    static let modelDidChange = NSNotification.Name("modelDidChange")
}

// MARK: - Adding New Measurement

/// Extension of `Notification.Name` to define a custom notification name for when a new measurement is added.
extension Notification.Name {
    /// Notification name for when a new measurement is added to the system.
    static let newMeasurementAdded = Notification.Name("newMeasurementAdded")
}

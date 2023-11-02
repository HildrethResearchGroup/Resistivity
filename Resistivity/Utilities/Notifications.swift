//
//  Notifications.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/2/23.
//

import Foundation

extension NSNotification.Name {
    static let disableMeasuring = NSNotification.Name("disableMeasuring")
    static let enableMeasuring = NSNotification.Name("enableMeasuring")
    static let disableStopping = NSNotification.Name("disableStopping")
    static let enableStopping = NSNotification.Name("enableStopping")
    static let modelDidChange = NSNotification.Name("modelDidChange")
}

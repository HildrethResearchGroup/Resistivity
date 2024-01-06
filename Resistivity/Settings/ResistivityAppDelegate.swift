//
//  ResistivityAppDelegate.swift
//  Resistivity
//
//  Created by Owen Hildreth on 12/29/23.
//

import Foundation
import Cocoa

/// `ResistivityAppDelegate` is the application delegate class responsible for handling
/// application-level events for the Resistivity app. It conforms to `NSApplicationDelegate`
/// which allows it to respond to application lifecycle events.
class ResistivityAppDelegate: NSObject, NSApplicationDelegate {
    
    /// Determines whether the application should terminate after the last window is closed.
    /// - Parameter sender: The application object that is controlling the application.
    /// - Returns: A Boolean value indicating whether the application should terminate.
    ///            Returning `true` will cause the application to terminate.
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

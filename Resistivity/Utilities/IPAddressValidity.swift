//
//  IPAddressValidity.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/7/23.
//

import Foundation
import Network

/// An enumeration representing the validity of an IP address.
enum IPAddressValidity {
    case valid
    case invalid
    
    /// Checks if the given IP address string is a valid IPv4 or IPv6 address.
    ///
    /// This method utilizes the `IPv4Address` and `IPv6Address` initializers from the Network framework
    /// to determine if the provided string is a valid IP address. It does not perform any additional
    /// validation beyond the format of the IP address.
    ///
    /// - Parameter address: A string representing the IP address to validate.
    /// - Returns: `.valid` if the address is a valid IPv4 or IPv6 address, `.invalid` otherwise.
    public func validIPAddress(_ address: String) -> IPAddressValidity {
        
        if let _ = IPv4Address(address) {
            return .valid
        } else if let _ = IPv6Address(address) {
            return .valid
        } else {
            return .invalid
        }
    }
}

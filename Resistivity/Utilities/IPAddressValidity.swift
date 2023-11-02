//
//  IPAddressValidity.swift
//  Resistivity
//
//  Created by Owen Hildreth on 10/7/23.
//

import Foundation

import Network

enum IPAddressValidity {
    case valid
    case invalid
    
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

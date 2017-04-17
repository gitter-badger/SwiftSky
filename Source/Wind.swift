//
//  Wind.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 16/04/2017.
//
//

import Foundation

/// Contains a `Bearing` and `Speed` of the wind
public struct Wind {
    
    /// `Bearing` of the wind
    public let bearing : Bearing?
    
    /// `Speed` of the wind
    public let speed : Speed?
    
    var hasData : Bool {
        if bearing != nil { return true }
        if speed != nil { return true }
        return false
    }
}

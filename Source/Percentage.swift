//
//  Percentage.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 16/04/2017.
//
//

import Foundation

/// Contains a value, 0 to 1 representation and label describing percentage
public struct Percentage {
    
    /// `Float` between 0.0 and 1.0 representing 0% and 100%, respectively
    public let zeroToOne : Float
    
    /// `Int` representing a percentage
    public let value : Int
    
    /// Human-readable representation of the percentage
    public let label : String
    
    init(_ value : Float) {
        zeroToOne = value
        self.value = Int(roundf(value * 100))
        label = "\(self.value)%"
    }
}

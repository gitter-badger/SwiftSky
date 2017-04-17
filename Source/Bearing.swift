//
//  Bearing.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 16/04/2017.
//
//

import Foundation

/// Direction in degrees with true north at 0° and progressing clockwise
public struct Bearing {
    
    /// `Float` between 0.0 and 1.0 representing 0° and 360°, respectively
    public let zeroToOne : Float
    
    /// `Int` representing the degrees from true north in a clockwise progression
    public let degrees : Int
    
    /// Human-readable representation of `Bearing.degrees`
    public let label : String
    
    /// Human-readable cardinal point representation of `Bearing.degrees`
    public let cardinalLabel : String
    
    init(_ value : Float) {
        degrees = Int(roundf(value))
        zeroToOne = value / 360
        label = "\(degrees)°"
        let directions : [String] = ["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
        cardinalLabel = directions[Int((Double(degrees) + 11.25) / 22.5) % 16]
    }
}

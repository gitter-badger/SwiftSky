//
//  Moon.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/// Shape of the illuminated portion of the Moon
public enum MoonPhase : String {
    
    /// Completely invisible
    case new = "new"
    
    /// Between `MoonPhase.new` and `MoonPhase.firstQuarter`
    case waxingCrescent = "waxing-crescent"
    
    /// First quarter of the moon is visible
    case firstQuarter = "first-quarter"
    
    /// Between `MoonPhase.firstQuarter` and `MoonPhase.full`
    case waxingGibbous = "waxing-gibbous"
    
    /// Completely visible
    case full = "full"
    
    /// Between `MoonPhase.full` and `MoonPhase.lastQuarter`
    case waningGibbous = "waning-gibbous"
    
    /// Last quarter of the moon is visible
    case lastQuarter = "last-quarter"
    
    /// Between `MoonPhase.lastQuarter` and `MoonPhase.new`
    case waningCrescent = "waning-crescent"
}

/// Contains a `MoonPhase`, `Percentage` and `Float` value describing the moon's phase
public struct MoonValue {
    
    /**
     Fractional part of the 
     [lunation number](https://en.wikipedia.org/wiki/New_moon#Lunation_Number)
    */
    public let fraction : Float
    
    /**
     Phase of the moon
     
     __Moon Phases__
     
     ```swift
     new
     waxing-crescent
     first-quarter
     waxing-gibbous
     full
     waning-gibbous
     last-quarter
     waning-crescent
     
    */
    public let phase : MoonPhase
    
    /// `String` representation of a `MoonPhase`
    public var phaseString : String { return phase.rawValue }
    
    init(_ value : Float) {
        fraction = value
        if value == 0 {
            phase = .new
        } else if value > 0 && value < 0.25 {
            phase = .waxingCrescent
        } else if value == 0.25 {
            phase = .firstQuarter
        } else if value > 0.25 && value < 0.5 {
            phase = .waxingGibbous
        } else if value == 0.5 {
            phase = .full
        } else if value > 0.5 && value < 0.75 {
            phase = .waningGibbous
        } else if value == 0.75 {
            phase = .lastQuarter
        } else {
            phase = .waningCrescent
        }
    }
}

//
//  Pressure.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 16/04/2017.
//
//

import Foundation

/// Contains a value, unit and a label describing atmospheric pressure
public struct Pressure {
    
    /// `Float` representing atmospheric pressure
    public let value : Float
    
    /// `PressureUnit` of the value
    public let unit : PressureUnit
    
    /// Human-readable representation of the value and unit together
    public var label : String {
        return label(as: unit)
    }
    
    /**
     Same as `Pressure.label`, but converted to a specific unit
     
     - parameter unit: `PressureUnit` to convert label to
     - returns: String
     */
    public func label(as unit : PressureUnit) -> String {
        switch unit {
        case .millibar:
            return "\(value.noDecimal) mb"
        case .hectopascal:
            return "\(value.noDecimal) hPa"
        }
    }
    
    /**
     Same as `Pressure.value`, but converted to a specific unit
     
     - parameter unit: `PressureUnit` to convert value to
     - returns: Float
     */
    public func value(as unit : PressureUnit) -> Float {
        return value
    }
    
    init(_ value : Float, withUnit : PressureUnit) {
        unit = SwiftSky.units.pressure
        self.value = value
    }
}

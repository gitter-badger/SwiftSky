//
//  Speed.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/// Contains a value, unit and a label describing speed
public struct Speed {
    
    /// `Float` representing speed
    private(set) public var value : Float = 0
    
    /// `SpeedUnit` of the value
    public let unit : SpeedUnit
    
    /// Human-readable representation of the value and unit together
    public var label : String {
        return label(as: unit)
    }
    
    /**
     Same as `Speed.label`, but converted to a specific unit
     
     - parameter unit: `SpeedUnit` to convert label to
     - returns: String
     */
    public func label(as unit : SpeedUnit) -> String {
        let converted = (self.unit == unit ? value : convert(value, from: self.unit, to: unit))
        switch unit {
        case .milePerHour:
            return "\(converted.noDecimal) mph"
        case .kilometerPerHour:
            return "\(converted.noDecimal) kph"
        case .meterPerSecond:
            return "\(converted.oneDecimal) m/s"
        }
    }
    
    /**
     Same as `Speed.value`, but converted to a specific unit
     
     - parameter unit: `SpeedUnit` to convert value to
     - returns: Float
     */
    public func value(as unit : SpeedUnit) -> Float {
        return convert(value, from: self.unit, to: unit)
    }
    
    private func convert(_ value : Float, from : SpeedUnit, to : SpeedUnit) -> Float {
        switch from {
        case .milePerHour:
            switch to {
            case .milePerHour:
                return value
            case .kilometerPerHour:
                return value * 1.609344
            case .meterPerSecond:
                return value * 0.44704
            }
        case .kilometerPerHour:
            switch to {
            case .kilometerPerHour:
                return value
            case .milePerHour:
                return value / 1.609344
            case .meterPerSecond:
                return value / 3.6
            }
        case .meterPerSecond:
            switch to {
            case .meterPerSecond:
                return value
            case .milePerHour:
                return value / 0.44704
            case .kilometerPerHour:
                return value * 3.6
            }
        }
    }
    
    init(_ value : Float, withUnit : SpeedUnit) {
        unit = SwiftSky.units.speed
        self.value = convert(value, from: withUnit, to: unit)
    }
}

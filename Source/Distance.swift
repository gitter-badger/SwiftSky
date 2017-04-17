//
//  Distance.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/// Contains a value, unit and label describing distance
public struct Distance {
    
    /// `Float` representing distance
    private(set) public var value : Float = 0
    
    /// `DistanceUnit` of the value
    public let unit : DistanceUnit
    
    /// Human-readable representation of the value and unit together
    public var label : String {
        return label(as: unit)
    }
    
    /**
     Same as `Distance.label`, but converted to a specific unit
     
     - parameter unit: `DistanceUnit` to convert label to
     - returns: String
    */
    public func label(as unit : DistanceUnit) -> String {
        let converted = (self.unit == unit ? value : convert(value, from: self.unit, to: unit))
        switch unit {
        case .mile:
            return "\(converted.oneDecimal) mi"
        case .yard:
            return "\(converted.noDecimal) yd"
        case .kilometer:
            return "\(converted.oneDecimal) km"
        case .meter:
            return "\(converted.noDecimal) m"
        }
    }
    
    /**
     Same as `Distance.value`, but converted to a specific unit
     
     - parameter unit: `DistanceUnit` to convert value to
     - returns: Float
    */
    public func value(as unit : DistanceUnit) -> Float {
        return convert(value, from: self.unit, to: unit)
    }
    
    private func convert(_ value : Float, from : DistanceUnit, to : DistanceUnit) -> Float {
        switch from {
        case .mile:
            switch to {
            case .mile:
                return value
            case .yard:
                return value * 1760
            case .kilometer:
                return value * 1.609344
            case .meter:
                return value * 1609.344
            }
        case .yard:
            switch to {
            case .yard:
                return value
            case .mile:
                return value / 1760
            case .kilometer:
                return value * 0.0009144
            case .meter:
                return value * 0.9144
            }
        case .kilometer:
            switch to {
            case .kilometer:
                return value
            case .mile:
                return value / 1.609344
            case .yard:
                return value / 0.0009144
            case .meter:
                return value * 1000
            }
        case .meter:
            switch to {
            case .meter:
                return value
            case .mile:
                return value / 1609.344
            case .yard:
                return value / 0.9144
            case .kilometer:
                return value / 1000
            }
        }
    }
    
    init(_ value : Float, withUnit : DistanceUnit) {
        unit = SwiftSky.units.distance
        self.value = convert(value, from: withUnit, to: unit)
    }
}

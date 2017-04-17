//
//  Temperature.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/// Contains a value, unit and a label describing temperature
public struct Temperature {
    
    /// `Float` representing temperature
    private(set) public var value : Float = 0
    
    /// `TemperatureUnit` of the value
    public let unit : TemperatureUnit
    
    /// Human-readable representation of the value and unit together
    public var label : String { return label(as: unit) }
    
    /**
     Same as `Temperature.label`, but converted to a specific unit
     
     - parameter unit: `TemperatureUnit` to convert label to
     - returns: String
     */
    public func label(as unit : TemperatureUnit) -> String {
        let converted = (self.unit == unit ? value : convert(value, from: self.unit, to: unit))
        switch unit {
        case .fahrenheit:
            return "\(converted.noDecimal)℉"
        case .celsius:
            return "\(converted.noDecimal)℃"
        case .kelvin:
            return "\(converted.noDecimal)K"
        }
    }
    
    /**
     Same as `Temperature.value`, but converted to a specific unit
     
     - parameter unit: `TemperatureUnit` to convert value to
     - returns: Float
     */
    public func value(as unit : TemperatureUnit) -> Float {
        return convert(value, from: self.unit, to: unit)
    }
    
    private func convert(_ value : Float, from : TemperatureUnit, to : TemperatureUnit) -> Float {
        switch from {
        case .fahrenheit:
            switch to {
            case .fahrenheit:
                return value
            case .celsius:
                return (value - 32) * (5/9)
            case .kelvin:
                return (value + 459.67) * (5/9)
            }
        case .celsius:
            switch to {
            case .celsius:
                return value
            case .fahrenheit:
                return value * (9/5) + 32
            case .kelvin:
                return value + 273.15
            }
        case .kelvin:
            switch to {
            case .kelvin:
                return value
            case .fahrenheit:
                return ((value - 273.15) * 1.8) + 32
            case .celsius:
                return value - 273.15
            }
        }
    }
    
    init(_ value : Float, withUnit : TemperatureUnit) {
        unit = SwiftSky.units.temperature
        self.value = convert(value, from: withUnit, to: unit)
    }
}

/// Contains real-feel current, maximum and minimum `Temperature` values
public struct ApparentTemperature {
    
    /// Current real-feel `Temperature`
    public let current : Temperature?
    
    /// Maximum value of real-feel `Temperature` during a given day
    public let max : Temperature?
    
    /// Time when `ApparentTemperature.max` occurs during a given day
    public let maxTime : Date?
    
    /// Minimum value of real-feel `Temperature` during a given day
    public let min : Temperature?
    
    /// Time when `ApparentTemperature.min` occurs during a given day
    public let minTime : Date?
    
    var hasData : Bool {
        if current != nil { return true }
        if max != nil { return true }
        if maxTime != nil { return true }
        if min != nil { return true }
        if minTime != nil { return true }
        return false
    }
}

/// Contains current, maximum, minimum and apparent `Temperature` values
public struct Temperatures {
    
    /// Current `Temperature`
    public let current : Temperature?
    
    /// Maximum value of `Temperature` during a given day
    public let max : Temperature?
    
    /// Time when `Temperatures.max` occurs during a given day
    public let maxTime : Date?
    
    /// Minimum value of `Temperature` during a given day
    public let min : Temperature?
    
    /// Time when `Temperatures.min` occurs during a given day
    public let minTime : Date?
    
    /// `ApparentTemperature` value with real-feel `Temperature`s
    public let apparent : ApparentTemperature?
    
    var hasData : Bool {
        if current != nil { return true }
        if max != nil { return true }
        if maxTime != nil { return true }
        if min != nil { return true }
        if minTime != nil { return true }
        if apparent?.hasData == true { return true }
        return false
    }
}

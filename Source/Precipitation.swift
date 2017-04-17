//
//  Precipitation.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/// Defines a type of `Precipitation`
public enum PrecipitationType : String {
    
    /// Rain is occuring or will occur
    case rain = "rain"
    
    /// Snow is occuring or will occur
    case snow = "snow"
    
    /// Freezing rain, ice pellets, or a wintery mix is occuring or will occur
    case sleet = "sleet"
    
    /// Hail is occuring or will occur (not implemented yet)
    case hail = "hail"
    
}

/// Contains a value, unit and a label describing `Precipitation` intensity
public struct Intensity {
    
    /// `Float` representing `Precipitation` intensity
    private(set) public var value : Float = 0
    
    /// `PrecipitationUnit` of the value
    public let unit : PrecipitationUnit
    
    /// Human-readable representation of the value and unit together
    public var label : String { return label(as: unit) }
    
    /**
     Same as `Intensity.label`, but converted to a specific unit
     
     - parameter unit: `PrecipitationUnit` to convert label to
     - returns: String
    */
    public func label(as unit : PrecipitationUnit) -> String {
        let converted = (self.unit == unit ? value : convert(value, from: self.unit, to: unit))
        switch unit {
        case .inch:
            return "\(converted.twoDecimal) in"
        case .millimeter:
            return "\(converted.oneDecimal) mm"
        }
    }
    
    /**
     Same as `Intensity.value`, but converted to a specific unit
     
     - parameter unit: `PrecipitationUnit` to convert value to
     - returns: Float
    */
    public func value(as unit : PrecipitationUnit) -> Float {
        return convert(value, from: self.unit, to: unit)
    }
    
    private func convert(_ value : Float, from : PrecipitationUnit, to : PrecipitationUnit) -> Float {
        switch from {
        case .inch:
            switch to {
            case .inch:
                return value
            case .millimeter:
                return value * 25.4
            }
        case .millimeter:
            switch to {
            case .millimeter:
                return value
            case .inch:
                return value / 25.4
            }
        }
    }
    
    init(_ value : Float, withUnit : PrecipitationUnit) {
        unit = SwiftSky.units.precipitation
        self.value = convert(value, from: withUnit, to: unit)
    }
}

/// Contains a value, unit and a label describing accumulation of snowfall
public struct Accumulation {
    
    /// `Float` representing accumulation of snowfall
    private(set) public var value : Float = 0
    
    /// `AccumulationUnit` of the value
    public let unit : AccumulationUnit
    
    /// Human-readable representation of the value and unit together
    public var label : String { return label(as: unit) }
    
    /**
     Same as `Accumulation.label`, but converted to a specific unit
     
     - parameter unit: `AccumulationUnit` to convert label to
     - returns: String
    */
    public func label(as unit : AccumulationUnit) -> String {
        let converted = (self.unit == unit ? value : convert(value, from: self.unit, to: unit))
        switch unit {
        case .inch:
            return "\(converted.twoDecimal) in"
        case .centimeter:
            return "\(converted.oneDecimal) cm"
        }
    }
    
    /**
     Same as `Accumulation.value`, but converted to a specific unit
     
     - parameter unit: `AccumulationUnit` to convert value to
     - returns: Float
    */
    public func value(as unit : AccumulationUnit) -> Float {
        return convert(value, from: self.unit, to: unit)
    }
    
    private func convert(_ value : Float, from : AccumulationUnit, to : AccumulationUnit) -> Float {
        switch from {
        case .inch:
            switch to {
            case .inch:
                return value
            case .centimeter:
                return value * 2.54
            }
        case .centimeter:
            switch to {
            case .centimeter:
                return value
            case .inch:
                return value / 2.54
            }
        }
    }
    
    init(_ value : Float, withUnit : AccumulationUnit) {
        unit = SwiftSky.units.accumulation
        self.value = convert(value, from: withUnit, to: unit)
    }
}

/// Contains type, intensity, accumulation and probability of precipitation
public struct Precipitation {
    
    /**
     Type of `Precipitation`
     
     __Precipitation Types__
     
     ```swift
     rain
     snow
     sleet
     hail
     
    */
    public let type : PrecipitationType?
    
    /// Amount of snowfall accumulation expected to occur
    public let accumulation : Accumulation?
    
    /// `Intensity` of precipitation occurring at the given time
    public let intensity : Intensity?
    
    /// Maximum value of `Intensity` during a given day
    public let maxIntensity : Intensity?
    
    /// Time when `Precipitation.max` occurs during a given day
    public let maxIntensityTime : Date?
    
    /// Probability of precipitation in a `Percentage` value
    public let probability : Percentage?
    
    var hasData : Bool {
        if type != .none { return true }
        if accumulation != nil { return true }
        if intensity != nil { return true }
        if maxIntensity != nil { return true }
        if maxIntensityTime != nil { return true }
        if probability != nil { return true }
        return false
    }
}

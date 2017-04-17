//
//  Units.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/// The unit used for `Temperature` values
public enum TemperatureUnit {
    
    /// Represents the Fahrenheit unit [(wikipedia)](https://en.wikipedia.org/wiki/Fahrenheit)
    case fahrenheit
    
    /// Represents the Celsius unit [(wikipedia)](https://en.wikipedia.org/wiki/Celsius)
    case celsius
    
    /// Represents the Kelvin unit [(wikipedia)](https://en.wikipedia.org/wiki/Kelvin)
    case kelvin
    
}

/// The unit used for `Distance` values
public enum DistanceUnit {
    
    /// Represents the Mile unit [(wikipedia)](https://en.wikipedia.org/wiki/Mile)
    case mile
    
    /// Represents the Yard unit [(wikipedia)](https://en.wikipedia.org/wiki/Yard)
    case yard
    
    /// Represents the Kilometer unit [(wikipedia)](https://en.wikipedia.org/wiki/Kilometre)
    case kilometer
    
    /// Represents the Meter unit [(wikipedia)](https://en.wikipedia.org/wiki/Metre)
    case meter
    
}

/// The unit used for `Speed` values
public enum SpeedUnit {
    
    /// Represents the Miles per Hour unit [(wikipedia)](https://en.wikipedia.org/wiki/Miles_per_hour)
    case milePerHour
    
    /// Represents the Kilometer per Hour unit [(wikipedia)](https://en.wikipedia.org/wiki/Kilometres_per_hour)
    case kilometerPerHour
    
    /// Represents the Meter per Second unit [(wikipedia)](https://en.wikipedia.org/wiki/Metre_per_second)
    case meterPerSecond

}

/// The unit used for `Pressure` values
public enum PressureUnit {
    
    /// Represents the Millibar unit [(wikipedia)](https://en.wikipedia.org/wiki/Bar_(unit))
    case millibar
    
    /// Represents the Hecto Pascal unit [(wikipedia)](https://en.wikipedia.org/wiki/Pascal_(unit))
    case hectopascal

}

/// The unit used for precipitation `Intensity` values
public enum PrecipitationUnit {
    
    /// Represents the Inch unit [(wikipedia)](https://en.wikipedia.org/wiki/Inch)
    case inch
    
    /// Represents the Millimeter unit [(wikipedia)](https://en.wikipedia.org/wiki/Millimetre)
    case millimeter

}

/// The unit used for precipitation `Accumulation` values
public enum AccumulationUnit {
    
    /// Represents the Inch unit [(wikipedia)](https://en.wikipedia.org/wiki/Inch)
    case inch
    
    /// Represents the Centimeter unit [(wikipedia)](https://en.wikipedia.org/wiki/Centimetre)
    case centimeter

}

/// Specifies the units to use for values in a `DataPoint`
public struct UnitProfile {
    
    /// The unit to use for `Temperature` values
    public var temperature : TemperatureUnit = .fahrenheit
    
    /// The unit to use for `Distance` values
    public var distance : DistanceUnit = .mile
    
    /// The unit to use for `Speed` values
    public var speed : SpeedUnit = .milePerHour
    
    /// The unit to use for `Pressure` values
    public var pressure : PressureUnit = .millibar
    
    /// The unit to use for `Intensity` precipitation values
    public var precipitation : PrecipitationUnit = .inch
    
    /// The unit to use for `Accumulation` precipitation values
    public var accumulation : AccumulationUnit = .inch
    
    private let profiles = ["us","ca","uk2","si"]
    var shortcode : String {
        var matchID : String = "us"
        var currentMatch : Int = 0
        for id in profiles {
            let apiProfile = ApiUnitProfile(id)
            var matchCount : Int = 0
            matchCount += (apiProfile.temperature == temperature ? 1 : 0)
            matchCount += (apiProfile.distance == distance ? 1 : 0)
            matchCount += (apiProfile.speed == speed ? 1 : 0)
            matchCount += (apiProfile.pressure == pressure ? 1 : 0)
            matchCount += (apiProfile.precipitation == precipitation ? 1 : 0)
            matchCount += (apiProfile.accumulation == accumulation ? 1 : 0)
            if matchCount > currentMatch {
                currentMatch = matchCount
                matchID = id
            }
        }
        return matchID
    }
    
}

struct ApiUnitProfile {
    
    let shortcode : String
    let temperature : TemperatureUnit
    let distance : DistanceUnit
    let speed : SpeedUnit
    let pressure : PressureUnit
    let precipitation : PrecipitationUnit
    let accumulation : AccumulationUnit
    
    init(_ string: String?) {
        shortcode = string ?? "us"
        switch string ?? "us" {
        case "ca":
            temperature = .celsius
            distance = .kilometer
            speed = .kilometerPerHour
            pressure = .hectopascal
            precipitation = .millimeter
            accumulation = .centimeter
        case "uk2":
            temperature = .celsius
            distance = .mile
            speed = .milePerHour
            pressure = .hectopascal
            precipitation = .millimeter
            accumulation = .centimeter
        case "si":
            temperature = .celsius
            distance = .kilometer
            speed = .meterPerSecond
            pressure = .hectopascal
            precipitation = .millimeter
            accumulation = .centimeter
        default:
            temperature = .fahrenheit
            distance = .mile
            speed = .milePerHour
            pressure = .millibar
            precipitation = .inch
            accumulation = .inch
        }
    }
    
}

//
//  DataPoint.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/**
 Contains various properties, representing the average (unless otherwise specified)
 of a particular weather phenomenon during a certain period of time,
 possibly one of: current, minutes, hours or days.
*/
public struct DataPoint {
    
    /**
     Time at which this `DataPoint` begins
     
     __Note:__
     
     Minutes are aligned to the top of the minute,
     hours are aligned to the top of the hour and days
     are aligned to the midnight of the day, all
     according to the local time zone
    */
    public let time : Date
    
    /// All `Temperature` related values
    public let temperature : Temperatures?
    
    /// All `Precipitation` related values
    public let precipitation : Precipitation?
    
    /// Nearest `Storm` (only on current datapoints)
    public let nearestStorm : Storm?
    
    /// `Wind` conditions for this `DataPoint`
    public let wind : Wind?
    
    /// `Temperature` at which the dew point lies
    public let dewPoint : Temperature?
    
    /// `MoonValue` representing moon state
    public let moon : MoonValue?
    
    /// Sea-level air `Pressure`
    public let pressure : Pressure?
    
    /// `Percentage` of sky occluded by clouds
    public let cloudCover : Percentage?
    
    /// Relative humidity as `Percentage`
    public let humidity : Percentage?
    
    /// Columnar density of total atmospheric `Ozone`
    public let ozone : Ozone?
    
    /// Average visibility as `Distance`, capped at 10mi (16km)
    public let visibility : Distance?
    
    /// Time at wich the sun rises
    public let sunrise : Date?
    
    /// Time at wich the sun sets
    public let sunset : Date?
    
    /// Human-readable summary of this `DataPoint`
    public let summary : String?
    
    /**
     Machine-readable summary of this `DataPoint` meant for icons
     
     __Note:__
     
     Will be one of the following values:
     
     `clear-day`, `clear-night`, `rain`, `snow`, `sleet`, `wind`, `fog`, `cloudy`, `partly-cloudy-day`, or `partly-cloudy-night`.
     
     Dark Sky notes that developers should ensure a sensible default is defined, as additional values, such as `hail`, `thunderstorm`, or `tornado`, may be defined in the future
    */
    public let icon : String?
    
    init(_ json : Dictionary<String, Any>, units : ApiUnitProfile) {

        let timeStamp = json["time"] as? Double
        time = (timeStamp != nil ? Date(timeIntervalSince1970: timeStamp!) : Date(timeIntervalSince1970: 0))
        
        let apparentTemperature = json["apparentTemperature"] as? Float
        let apparentTemperatureMax = json["apparentTemperatureMax"] as? Float
        let apparentTemperatureMaxTime = json["apparentTemperatureMaxTime"] as? Double
        let apparentTemperatureMin = json["apparentTemperatureMin"] as? Float
        let apparentTemperatureMinTime = json["apparentTemperatureMinTime"] as? Double
        
        let apparent = ApparentTemperature(
            current: (apparentTemperature != nil ? Temperature(apparentTemperature!, withUnit: units.temperature) : nil),
            max: (apparentTemperatureMax != nil ? Temperature(apparentTemperatureMax!, withUnit: units.temperature) : nil),
            maxTime: (apparentTemperatureMaxTime != nil ? Date(timeIntervalSince1970: apparentTemperatureMaxTime!) : nil),
            min: (apparentTemperatureMin != nil ? Temperature(apparentTemperatureMin!, withUnit: units.temperature) : nil),
            minTime: (apparentTemperatureMinTime != nil ? Date(timeIntervalSince1970: apparentTemperatureMinTime!) : nil)
        )
        
        let temperatureJSON = json["temperature"] as? Float
        let temperatureMax = json["temperatureMax"] as? Float
        let temperatureMaxTime = json["temperatureMaxTime"] as? Double
        let temperatureMin = json["temperatureMin"] as? Float
        let temperatureMinTime = json["temperatureMinTime"] as? Double
        
        let temperature = Temperatures(
            current: (temperatureJSON != nil ? Temperature(temperatureJSON!, withUnit: units.temperature) : nil),
            max: (temperatureMax != nil ? Temperature(temperatureMax!, withUnit: units.temperature) : nil),
            maxTime: (temperatureMaxTime != nil ? Date(timeIntervalSince1970: temperatureMaxTime!) : nil),
            min: (temperatureMin != nil ? Temperature(temperatureMin!, withUnit: units.temperature) : nil),
            minTime: (temperatureMinTime != nil ? Date(timeIntervalSince1970: temperatureMinTime!) : nil),
            apparent: (apparent.hasData ? apparent : nil)
        )
        self.temperature = (temperature.hasData ? temperature : nil)
        
        let precipAccumulation = json["precipAccumulation"] as? Float
        let precipIntensity = json["precipIntensity"] as? Float
        let precipIntensityMax = json["precipIntensityMax"] as? Float
        let precipIntensityMaxTime = json["precipIntensityMaxTime"] as? Double
        let precipProbability = json["precipProbability"] as? Float

        let precipitation = Precipitation(
            type: PrecipitationType(rawValue: (json["precipType"] as? String) ?? "none") ?? .none,
            accumulation: (precipAccumulation != nil ? Accumulation(precipAccumulation!, withUnit: units.accumulation) : nil),
            intensity: (precipIntensity != nil ? Intensity(precipIntensity!, withUnit: units.precipitation) : nil),
            maxIntensity: (precipIntensityMax != nil ? Intensity(precipIntensityMax!, withUnit: units.precipitation) : nil),
            maxIntensityTime: (precipIntensityMaxTime != nil ? Date(timeIntervalSince1970: precipIntensityMaxTime!) : nil),
            probability: (precipProbability != nil ? Percentage(precipProbability!) : nil)
        )
        self.precipitation = (precipitation.hasData ? precipitation : nil)
        
        let nearestStormBearing = json["nearestStormBearing"] as? Float
        let nearestStormDistance = json["nearestStormDistance"] as? Float
        
        let storm = Storm(
            bearing: (nearestStormBearing != nil ? Bearing(nearestStormBearing!) : nil),
            distance: (nearestStormDistance != nil ? Distance(nearestStormDistance!, withUnit: units.distance) : nil)
        )
        self.nearestStorm = (storm.hasData ? storm : nil)
        
        let windBearing = json["windBearing"] as? Float
        let windSpeed = json["windSpeed"] as? Float
        
        let wind = Wind(
            bearing: (windBearing != nil ? Bearing(windBearing!) : nil),
            speed: (windSpeed != nil ? Speed(windSpeed!, withUnit: units.speed) : nil)
        )
        self.wind = (wind.hasData ? wind : nil)
        
        let dewPoint = json["dewPoint"] as? Float
        self.dewPoint = (dewPoint != nil ? Temperature(dewPoint!, withUnit: units.temperature) : nil)
        
        let moonPhase = json["moonPhase"] as? Float
        self.moon = (moonPhase != nil ? MoonValue(moonPhase!) : nil)
        
        let pressure = json["pressure"] as? Float
        self.pressure = (pressure != nil ? Pressure(pressure!, withUnit: units.pressure) : nil)
        
        let cloudCover = json["cloudCover"] as? Float
        self.cloudCover = (cloudCover != nil ? Percentage(cloudCover!) : nil)
        
        let humidity = json["humidity"] as? Float
        self.humidity = (humidity != nil ? Percentage(humidity!) : nil)
        
        let ozone = json["ozone"] as? Float
        self.ozone = (ozone != nil ? Ozone(ozone!) : nil)
        
        let visibility = json["visibility"] as? Float
        self.visibility = (visibility != nil ? Distance(visibility!, withUnit: units.distance) : nil)
        
        let sunriseTime = json["sunriseTime"] as? Double
        self.sunrise = (sunriseTime != nil ? Date(timeIntervalSince1970: sunriseTime!) : nil)
        
        let sunsetTime = json["sunriseTime"] as? Double
        self.sunset = (sunriseTime != nil ? Date(timeIntervalSince1970: sunsetTime!) : nil)
        
        self.summary = json["summary"] as? String
        self.icon = json["icon"] as? String
        
    }
    
}

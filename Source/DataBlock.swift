//
//  DataBlock.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/// A type of data in a `Forecast`
public enum DataType : String {
    
    /// Current weather conditions
    case current = "currently"
    
    /// Weather conditions on per minute basis for the next hour
    case minutes = "minutely"
    
    /// Weather conditions on per hour basis for the next 2 or 7 days, based on `SwiftSky.hourAmount`
    case hours = "hourly"
    
    /// Weather conditions on per day basis for the next week
    case days = "daily"
    
    /// Weather alerts issued by a governmental authority
    case alerts = "alerts"
}

/// The various weather phenomena occurring over a period of time
public struct DataBlock {
    
    /**
     `Array` of `DataPoint`s, ordered by time, which 
     together describe the weather conditions over time
    */
    public let points : [DataPoint]
    
    /// Human-readable summary of this `DataBlock`
    public let summary : String?
    
    /**
     Machine-readable summary of this `DataBlock` meant for icons
     
     __Note:__
     
     Will be one of the following values:
     
     `clear-day`, `clear-night`, `rain`, `snow`, `sleet`, `wind`, `fog`, `cloudy`, `partly-cloudy-day`, or `partly-cloudy-night`.
     
     Dark Sky notes that developers should ensure a sensible default is defined, as additional values, such as `hail`, `thunderstorm`, or `tornado`, may be defined in the future
     */
    public let icon : String?
    
    init(_ json : Dictionary<String,Any>, units : ApiUnitProfile) {
        if let array = json["data"] as? Array<Dictionary<String,Any>> {
            var dataPoints : [DataPoint] = []
            for point in array {
                dataPoints.append(DataPoint(point, units: units))
            }
            points = dataPoints
        } else { points = [] }
        summary = json["summary"] as? String
        icon = json["icon"] as? String
    }
    
}

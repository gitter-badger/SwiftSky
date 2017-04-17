//
//  Forecast.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation
import CoreLocation

/// Metrics and origin for `Forecast`
public struct Metadata {
    
    /// Total amount of calls made with `SwiftSky.key`
    let totalCalls : Int?
    
    /// Amount of time it took the Dark Sky servers to respond
    let responseTime : TimeInterval?
    
    /**
     Presence of this property indicates that the Dark Sky data source supports
     the given location, but a temporary error  (such as a radar station being 
     down for maintenance) has made the data unavailable
    */
    let darkSkyUnavailable : Bool?
    
    /**
     `Array` of IDs (`String`) for each source used in creating this `Forecast`
     
     ## Current Sources:
    
     ```swift
     cmc
     darksky
     datapoint
     ecpa
     gfs
     isd
     madis
     metwarn
     nam
     nwspa
     rap
     rtma
     sref
     ```
     
     For a more detailed description see: [The Documentation](https://darksky.net/dev/docs/sources)

    */
    let sources : [String]?
    
}

/// Holds the `DataPoint`s, `DataBlock`s, `Alert`s and `Metadata` of a forecast for a location
public struct Forecast {
    
    /// `CLLocation` for which this forecast was generated
    public let location : CLLocation?
    
    /// `TimeZone` of `Forecast.location`
    public let timezone : TimeZone?
    
    /// Current weather conditions
    public let current : DataPoint?
    
    /// Weather conditions on a per minute basis for the next hour
    public let minutes : DataBlock?
    
    /// Weather conditions on a per hour basis for the next 2 or 7 days, based on `SwiftSky.hourAmount`
    public let hours : DataBlock?
    
    /// Weather conditions on a per day basis for the next week
    public let days : DataBlock?
    
    /// Weather alerts issued by a governmental authority
    public let alerts : [Alert]?
    
    /// `Metadata` for this forecast
    public let metadata : Metadata?
    
    init(_ data : Any?, headers : [AnyHashable : Any]?) {
        
        guard let json = data as? Dictionary<String,Any>,
            let flags = json["flags"] as? Dictionary<String,Any> else {
            location = nil
            timezone = nil
            current = nil
            minutes = nil
            hours = nil
            days = nil
            metadata = nil
            alerts = nil
            return
        }
        
        let units = ApiUnitProfile(flags["units"] as? String ?? "us")
        
        if let lat = json["latitude"] as? CLLocationDegrees, let lon = json["longitude"] as? CLLocationDegrees {
            location = CLLocation(latitude: lat, longitude: lon)
        } else { location = nil }
        
        if let zoneID = json["timezone"] as? String {
            timezone = TimeZone(identifier: zoneID)
        } else { timezone = nil }
        
        if let currently = json["currently"] as? Dictionary<String,Any> {
            current = DataPoint(currently, units: units)
        } else { current = nil }
        
        if let minutely = json["minutely"] as? Dictionary<String,Any> {
            minutes = DataBlock(minutely, units: units)
        } else { minutes = nil }
        
        if let hourly = json["hourly"] as? Dictionary<String,Any> {
            hours = DataBlock(hourly, units: units)
        } else { hours = nil }
        
        if let daily = json["daily"] as? Dictionary<String,Any> {
            days = DataBlock(daily, units: units)
        } else { days = nil }
        
        if let alertArray = json["alerts"] as? Array<Dictionary<String,Any>> {
            var alerts : [Alert] = []
            for alert in alertArray {
                alerts.append(Alert(alert))
            }
            self.alerts = alerts
        } else { alerts = nil }
        
        let responseString = (headers?["X-Response-Time"] as? String)?.trimmingCharacters(in: CharacterSet.letters)
        let apiCalls = headers?["X-Forecast-API-Calls"] as? String
        
        metadata = Metadata(
            totalCalls: (apiCalls != nil ? Int(apiCalls!) : nil),
            responseTime: (responseString != nil ? TimeInterval(responseString!) : nil),
            darkSkyUnavailable: flags["darksky-unavailable"] as? Bool,
            sources: flags["sources"] as? [String]
        )
        
    }
    
}

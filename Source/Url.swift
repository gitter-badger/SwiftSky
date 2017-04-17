//
//  Url.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation
import CoreLocation

struct ApiUrl {
    
    private let base = "https://api.darksky.net/forecast"
    let url : URL
    
    init(_ location: Location, date : Date?, exclude : [DataType]) {
        
        var urlString = "\(base)/\(SwiftSky.key ?? "NO_API_KEY")/\(location.latitude),\(location.longitude)"
        if let time = date {
            let timeString = String(format: "%.0f", time.timeIntervalSince1970)
            urlString.append(",\(timeString)")
        }
        
        var builder = URLComponents(string: urlString)
        var items : [URLQueryItem] = [
            URLQueryItem(name: "lang", value: SwiftSky.language.shortcode),
            URLQueryItem(name: "units", value: SwiftSky.units.shortcode)
        ]
        if SwiftSky.hourAmount == .hundredSixtyEight {
            items.append(URLQueryItem(name: "extend", value: "hourly"))
        }
        
        if !exclude.isEmpty {
            var excludeString = ""
            for type in exclude {
                if !excludeString.isEmpty { excludeString.append(",") }
                excludeString.append(type.rawValue)
            }
            items.append(URLQueryItem(name: "exclude", value: excludeString))
        }
        
        builder?.queryItems = items
        url = builder!.url!
        
    }
    
}

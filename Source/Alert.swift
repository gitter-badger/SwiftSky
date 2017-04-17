//
//  Alert.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/// Severity of a weather `Alert`
public enum AlertSeverity : String {
    
    /// Individual should be aware of potentially severe weather
    case advisory
    
    /// Individual should prepare for potentially severe weather
    case watch = "watch"
    
    /**
     Individual should take immediate action to protect
     themselves and others from potentially severe weather
    */
    case warning = "warning"
}

/// Severe weather warning issued by a governmental authority
public struct Alert {
    
    /// Brief description of the alert
    public let title: String
    
    /// Detailed description of the alert
    public let description: String
    
    /// Time at which the alert will expire, `nil` if not defined
    public let expiresAt: Date?
    
    /// `Array` of `String`s representing the the regions covered by this `Alert`
    public let regions : [String]
    
    /// Severity of this weather `Alert`
    public let severity : AlertSeverity
    
    /// Time at which this `Alert` was issued
    public let time : Date
    
    /// `URL` at which more details on this alert can be found, `nil` if not defined
    public let url: URL?

    init(_ json: Dictionary<String,Any>) {
        
        title = json["title"] as? String ?? ""
        description = json["description"] as? String ?? ""
        
        if let jsonExpires = json["expires"] as? Double {
            expiresAt = Date(timeIntervalSince1970: jsonExpires)
        } else { expiresAt = nil }
        
        regions = json["regions"] as? [String] ?? []
        severity = AlertSeverity(rawValue: json["severity"] as? String ?? "advisory") ?? .advisory
        time = Date(timeIntervalSince1970: json["time"] as? Double ?? 0)
        
        if let urlString = json["uri"] as? String {
            url = URL(string: urlString)!
        } else { url = nil }
        
    }
}

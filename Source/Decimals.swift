//
//  Decimals.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

extension Float {
    
    var noDecimal : String {
        return String(format: "%.0f", self)
    }
    
    var oneDecimal : String {
        let formatter = NumberFormatter()
        formatter.locale = SwiftSky.locale
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.minimumIntegerDigits = 1
        return formatter.string(from: NSNumber(value: self))!
    }
    
    var twoDecimal : String {
        let formatter = NumberFormatter()
        formatter.locale = SwiftSky.locale
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        return formatter.string(from: NSNumber(value: self))!
    }
    
}

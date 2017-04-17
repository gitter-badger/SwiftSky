//
//  Storm.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/// Contains a `Bearing` and `Distance` describing the location of a storm
public struct Storm {
    
    /// `Bearing` from requested location where a storm can be found
    public let bearing : Bearing?
    
    /// `Distance` from requested location where a storm can be found
    public let distance : Distance?
    
    var hasData : Bool {
        if bearing != nil { return true }
        if distance != nil { return true }
        return false
    }
}

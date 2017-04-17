//
//  UrlTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftSky

class UrlTest : QuickSpec {

    override func spec() {
        
        describe("url") {
            
            let location = Location(latitude: 0.12345, longitude: 0.12345)
            
            it("should create regular url") {
                expect(ApiUrl(location, date: nil, exclude: []).url.absoluteString).to(equal("https://api.darksky.net/forecast/NO_API_KEY/0.12345,0.12345?lang=en&units=us"))
            }
            
            it("should create extended url") {
                SwiftSky.hourAmount = .hundredSixtyEight
                expect(ApiUrl(location, date: nil, exclude: []).url.absoluteString).to(equal("https://api.darksky.net/forecast/NO_API_KEY/0.12345,0.12345?lang=en&units=us&extend=hourly"))
                SwiftSky.hourAmount = .fortyEight
            }
            
            it("should create history url") {
                let yesterday = Date(timeIntervalSinceNow: -86400)
                expect(ApiUrl(location, date: yesterday, exclude: []).url.absoluteString).to(equal("https://api.darksky.net/forecast/NO_API_KEY/0.12345,0.12345,\(String(format: "%.0f", yesterday.timeIntervalSince1970))?lang=en&units=us"))
            }
            
            it("should create exclude url") {
                expect(ApiUrl(location, date: nil, exclude: [.alerts]).url.absoluteString).to(equal("https://api.darksky.net/forecast/NO_API_KEY/0.12345,0.12345?lang=en&units=us&exclude=alerts"))
            }
            
            it("should create multie exclude url") {
                expect(ApiUrl(location, date: nil, exclude: [.alerts,.current]).url.absoluteString).to(equal("https://api.darksky.net/forecast/NO_API_KEY/0.12345,0.12345?lang=en&units=us&exclude=alerts,currently"))
            }
            
        }
        
    }
    
}

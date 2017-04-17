//
//  MoonTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftSky

class MoonTest : QuickSpec {

    override func spec() {
        
        describe("moon") { 
            
            context("phase id", {
                it("should be") {
                    let moon = MoonValue(0)
                    expect(moon.phaseString).to(equal("new"))
                }
            })
            
            context("waxing crescent", {
                it("should be") {
                    let moon = MoonValue(0.2)
                    expect(moon.phaseString).to(equal("waxing-crescent"))
                }
            })
            
            context("first quarter", {
                it("should be") {
                    let moon = MoonValue(0.25)
                    expect(moon.phaseString).to(equal("first-quarter"))
                }
            })
            
            context("waxing gibbous", {
                it("should be") {
                    let moon = MoonValue(0.3)
                    expect(moon.phaseString).to(equal("waxing-gibbous"))
                }
            })
            
            context("full", {
                it("should be") {
                    let moon = MoonValue(0.5)
                    expect(moon.phaseString).to(equal("full"))
                }
            })
            
            context("waning gibbous", {
                it("should be") {
                    let moon = MoonValue(0.6)
                    expect(moon.phaseString).to(equal("waning-gibbous"))
                }
            })
            
            context("last quarter", {
                it("should be") {
                    let moon = MoonValue(0.75)
                    expect(moon.phaseString).to(equal("last-quarter"))
                }
            })
            
            context("waning crescent", {
                it("should be") {
                    let moon = MoonValue(0.8)
                    expect(moon.phaseString).to(equal("waning-crescent"))
                }
            })
            
        }
        
    }

}

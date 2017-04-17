//
//  ExtraDataTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftSky

class ExtraDataTest : QuickSpec {

    override func spec() {
        
        describe("pressure") {
            let pressure = Pressure(500, withUnit: .millibar)
            
            context("creation", {
                it("should have") {
                    expect(pressure.value).to(equal(500))
                    expect(pressure.unit).to(equal(PressureUnit.millibar))
                }
            })
            
            context("labels", { 
                it("should be") {
                    expect(pressure.label).to(equal("500 mb"))
                    expect(pressure.label(as: .hectopascal)).to(equal("500 hPa"))
                }
            })
            
            context("value conversion", { 
                it("should be") {
                    expect(pressure.value(as: .hectopascal)).to(equal(500))
                }
            })
            
        }
        
        describe("ozone") {
            it("should create") {
                let ozone = Ozone(600)
                expect(ozone.value).to(equal(600))
                expect(ozone.label).to(equal("600 DU"))
            }
        }
        
        let bearing = Bearing(180)
        describe("bearing") { 
            it("should create") {
                expect(bearing.zeroToOne).to(equal(0.5))
                expect(bearing.degrees).to(equal(180))
                expect(bearing.label).to(equal("180°"))
                expect(bearing.cardinalLabel).to(equal("S"))
            }
        }
        
        describe("wind") { 
            it("should have no data") {
                let wind = Wind(bearing: nil, speed: nil)
                expect(wind.hasData).to(equal(false))
            }
            
            it("should have bearing") {
                let wind = Wind(bearing: bearing, speed: nil)
                expect(wind.hasData).to(equal(true))
            }
            
            it("should have speed") {
                let wind = Wind(bearing: nil, speed: Speed(10, withUnit: .meterPerSecond))
                expect(wind.hasData).to(equal(true))
            }
        }
        
        describe("storm") {
            it("should have no data") {
                let wind = Storm(bearing: nil, distance: nil)
                expect(wind.hasData).to(equal(false))
            }

            it("should have speed") {
                let wind = Storm(bearing: bearing, distance: nil)
                expect(wind.hasData).to(equal(true))
            }
            
            it("should have distance") {
                let wind = Storm(bearing: nil, distance: Distance(100, withUnit: .meter))
                expect(wind.hasData).to(equal(true))
            }
        }
        
    }
    
}

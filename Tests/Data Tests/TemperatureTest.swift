//
//  TemperatureTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftSky

class TemperatureTest : QuickSpec {
    
    override func tearDown() {
        SwiftSky.units = UnitProfile()
        super.tearDown()
    }
    
    override func spec() {
        
        let fahrenheit = Temperature(68, withUnit: .fahrenheit)
        describe("temperature label") {
            
            context("label", { 
                it("should be") { 
                    expect(fahrenheit.label).to(equal("68℉"))
                }
            })
            
            context("celsius label", { 
                it("should be") { 
                    expect(fahrenheit.label(as: .celsius)).to(equal("20℃"))
                }
            })
            
            context("kelvin label", {
                it("should be") {
                    expect(fahrenheit.label(as: .kelvin)).to(equal("293K"))
                }
            })
            
        }
        
        describe("temperature converting") { 
            
            context("fahrenheit to fahrenheit", {
                it("should be") {
                    expect(fahrenheit.value(as: .fahrenheit)).to(equal(68))
                }
            })
            
            context("fahrenheit to celsius", {
                it("should be") {
                    expect(fahrenheit.value(as: .celsius)).to(equal(20))
                }
            })
            
            context("fahrenheit to kelvin", {
                it("should be") {
                    expect(fahrenheit.value(as: .kelvin)).to(equal((68 + 459.67) * (5/9)))
                }
            })
            
            SwiftSky.units.temperature = .celsius
            let celsius = Temperature(20, withUnit: .celsius)
            context("celsius to fahrenheit", {
                it("should be") {
                    expect(celsius.value(as: .fahrenheit)).to(equal(68))
                }
            })
            
            context("celsius to celsius", {
                it("should be") {
                    expect(celsius.value(as: .celsius)).to(equal(20))
                }
            })
            
            context("celsius to kelvin", {
                it("should be") {
                    expect(celsius.value(as: .kelvin)).to(equal(293.15))
                }
            })
            
            SwiftSky.units.temperature = .kelvin
            let kelvin = Temperature(293.15, withUnit: .kelvin)
            context("kelvin to celsius", {
                it("should be") {
                    expect(kelvin.value(as: .celsius)).to(equal(20))
                }
            })
            
            context("kelvin to fahrenheit", {
                it("should be") {
                    expect(kelvin.value(as: .fahrenheit)).to(equal(68))
                }
            })
            
            context("kelvin to kelvin", {
                it("should be") {
                    expect(kelvin.value(as: .kelvin)).to(equal(293.15))
                }
            })
            
        }
        
        describe("apparent temperature") {
            
            context("no data", { 
                it("should be") {
                    let apparent = ApparentTemperature(current: nil, max: nil, maxTime: nil, min: nil, minTime: nil)
                    expect(apparent.hasData).to(equal(false))
                }
            })
            
            context("current", { 
                it("should have data") {
                    let apparent = ApparentTemperature(current: fahrenheit, max: nil, maxTime: nil, min: nil, minTime: nil)
                    expect(apparent.hasData).to(equal(true))
                }
            })
            
            context("max", {
                it("should have data") {
                    let apparent = ApparentTemperature(current: nil, max: fahrenheit, maxTime: nil, min: nil, minTime: nil)
                    expect(apparent.hasData).to(equal(true))
                }
            })
            
            context("max time", {
                it("should have data") {
                    let apparent = ApparentTemperature(current: nil, max: nil, maxTime: Date(), min: nil, minTime: nil)
                    expect(apparent.hasData).to(equal(true))
                }
            })
            
            context("min", {
                it("should have data") {
                    let apparent = ApparentTemperature(current: nil, max: nil, maxTime: nil, min: fahrenheit, minTime: nil)
                    expect(apparent.hasData).to(equal(true))
                }
            })
            
            context("min time", {
                it("should have data") {
                    let apparent = ApparentTemperature(current: nil, max: nil, maxTime: nil, min: nil, minTime: Date())
                    expect(apparent.hasData).to(equal(true))
                }
            })
            
        }
        
        describe("temperature object") {
            
            context("no data", {
                it("should be") {
                    let object = Temperatures(current: nil, max: nil, maxTime: nil, min: nil, minTime: nil, apparent: nil)
                    expect(object.hasData).to(equal(false))
                }
            })
            
            context("current", {
                it("should have data") {
                    let object = Temperatures(current: fahrenheit, max: nil, maxTime: nil, min: nil, minTime: nil, apparent: nil)
                    expect(object.hasData).to(equal(true))
                }
            })
            
            context("max", {
                it("should have data") {
                    let object = Temperatures(current: nil, max: fahrenheit, maxTime: nil, min: nil, minTime: nil, apparent: nil)
                    expect(object.hasData).to(equal(true))
                }
            })
            
            context("max time", {
                it("should have data") {
                    let object = Temperatures(current: nil, max: nil, maxTime: Date(), min: nil, minTime: nil, apparent: nil)
                    expect(object.hasData).to(equal(true))
                }
            })
            
            context("min", {
                it("should have data") {
                    let object = Temperatures(current: nil, max: nil, maxTime: nil, min: fahrenheit, minTime: nil, apparent: nil)
                    expect(object.hasData).to(equal(true))
                }
            })
            
            context("min time", {
                it("should have data") {
                    let object = Temperatures(current: nil, max: nil, maxTime: nil, min: nil, minTime: Date(), apparent: nil)
                    expect(object.hasData).to(equal(true))
                }
            })
            
            context("apparent", {
                it("should have data") {
                    let object = Temperatures(current: nil, max: nil, maxTime: nil, min: nil, minTime: nil,
                        apparent: ApparentTemperature(current: fahrenheit, max: nil, maxTime: nil, min: nil, minTime: nil))
                    expect(object.hasData).to(equal(true))
                }
            })
            
        }
        
    }
    
}

//
//  UnitTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftSky

class UnitTest : QuickSpec {

    override func spec() {
        
        describe("units") {
            
            context("default units", { 
                it("should be") {
                    let units = SwiftSky.units
                    expect(units.temperature).to(equal(TemperatureUnit.fahrenheit))
                    expect(units.distance).to(equal(DistanceUnit.mile))
                    expect(units.speed).to(equal(SpeedUnit.milePerHour))
                    expect(units.precipitation).to(equal(PrecipitationUnit.inch))
                    expect(units.accumulation).to(equal(AccumulationUnit.inch))
                    expect(units.pressure).to(equal(PressureUnit.millibar))
                }
            })
            
            context("us shortcode", {
                it("should be") {
                    let profile = UnitProfile(temperature: .fahrenheit, distance: .mile, speed: .milePerHour, pressure: .millibar, precipitation: .inch, accumulation: .inch)
                    expect(profile.shortcode).to(equal("us"))
                }
            })
            
            context("si shortcode", {
                it("should be") {
                    let profile = UnitProfile(temperature: .celsius, distance: .kilometer, speed: .meterPerSecond, pressure: .hectopascal, precipitation: .millimeter, accumulation: .centimeter)
                    expect(profile.shortcode).to(equal("si"))
                }
            })
            
            context("ca shortcode", {
                it("should be") {
                    let profile = UnitProfile(temperature: .celsius, distance: .kilometer, speed: .kilometerPerHour, pressure: .millibar, precipitation: .millimeter, accumulation: .centimeter)
                    expect(profile.shortcode).to(equal("ca"))
                }
            })
            
            context("uk2 shortcode", {
                it("should be") {
                    let profile = UnitProfile(temperature: .celsius, distance: .mile, speed: .milePerHour, pressure: .millibar, precipitation: .millimeter, accumulation: .centimeter)
                    expect(profile.shortcode).to(equal("uk2"))
                }
            })
            
            context("api unit profiles", {
                
                context("ca unit profile", {
                    it("should have units") {
                        let caProfile = ApiUnitProfile("ca")
                        expect(caProfile.temperature).to(equal(TemperatureUnit.celsius))
                        expect(caProfile.distance).to(equal(DistanceUnit.kilometer))
                        expect(caProfile.speed).to(equal(SpeedUnit.kilometerPerHour))
                        expect(caProfile.precipitation).to(equal(PrecipitationUnit.millimeter))
                        expect(caProfile.accumulation).to(equal(AccumulationUnit.centimeter))
                        expect(caProfile.pressure).to(equal(PressureUnit.hectopascal))
                    }
                })
                
                context("uk2 unit profile", {
                    it("should have units") {
                        let caProfile = ApiUnitProfile("uk2")
                        expect(caProfile.temperature).to(equal(TemperatureUnit.celsius))
                        expect(caProfile.distance).to(equal(DistanceUnit.mile))
                        expect(caProfile.speed).to(equal(SpeedUnit.milePerHour))
                        expect(caProfile.precipitation).to(equal(PrecipitationUnit.millimeter))
                        expect(caProfile.accumulation).to(equal(AccumulationUnit.centimeter))
                        expect(caProfile.pressure).to(equal(PressureUnit.hectopascal))
                    }
                })
                
                context("si unit profile", {
                    it("should have units") {
                        let caProfile = ApiUnitProfile("si")
                        expect(caProfile.temperature).to(equal(TemperatureUnit.celsius))
                        expect(caProfile.distance).to(equal(DistanceUnit.kilometer))
                        expect(caProfile.speed).to(equal(SpeedUnit.meterPerSecond))
                        expect(caProfile.precipitation).to(equal(PrecipitationUnit.millimeter))
                        expect(caProfile.accumulation).to(equal(AccumulationUnit.centimeter))
                        expect(caProfile.pressure).to(equal(PressureUnit.hectopascal))
                    }
                })
                
                context("us unit profile", {
                    it("should have units") {
                        let caProfile = ApiUnitProfile("us")
                        expect(caProfile.temperature).to(equal(TemperatureUnit.fahrenheit))
                        expect(caProfile.distance).to(equal(DistanceUnit.mile))
                        expect(caProfile.speed).to(equal(SpeedUnit.milePerHour))
                        expect(caProfile.precipitation).to(equal(PrecipitationUnit.inch))
                        expect(caProfile.accumulation).to(equal(AccumulationUnit.inch))
                        expect(caProfile.pressure).to(equal(PressureUnit.millibar))
                    }
                })
                
                context("fallback unit profile", {
                    it("should have units") {
                        let caProfile = ApiUnitProfile(nil)
                        expect(caProfile.temperature).to(equal(TemperatureUnit.fahrenheit))
                        expect(caProfile.distance).to(equal(DistanceUnit.mile))
                        expect(caProfile.speed).to(equal(SpeedUnit.milePerHour))
                        expect(caProfile.precipitation).to(equal(PrecipitationUnit.inch))
                        expect(caProfile.accumulation).to(equal(AccumulationUnit.inch))
                        expect(caProfile.pressure).to(equal(PressureUnit.millibar))
                    }
                })
                
            })
            
        }
        
    }
    
}

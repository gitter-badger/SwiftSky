//
//  PrecipitationTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftSky

class PrecipitationTest : QuickSpec {

    override func tearDown() {
        SwiftSky.units = UnitProfile()
        SwiftSky.locale = Locale.current
        super.tearDown()
    }
    
    override func setUp() {
        SwiftSky.locale = Locale(identifier: "en-US")
    }
    
    override func spec() {
        
        let inches = Intensity(0.4, withUnit: .inch)
        describe("intensity label") {
            
            context("regular", {
                it("should be") {
                    expect(inches.label).to(equal("0.4 in"))
                }
            })
            
            context("millimeters", {
                it("should be") {
                    expect(inches.label(as: .millimeter)).to(equal("10.2 mm"))
                }
            })
        
        }
        
        SwiftSky.units.precipitation = .millimeter
        let millimeters = Intensity(10.16, withUnit: .millimeter)
        describe("intensity convert") {
            
            context("millimeters", {
                it("should be") {
                    expect(millimeters.value(as: .millimeter)).to(equal(10.16))
                }
            })
            
            context("inches", {
                it("should be") {
                    expect(millimeters.value(as: .inch)).to(equal(0.4))
                }
            })
            
        }
        
        let inchAccu = Accumulation(0.4, withUnit: .inch)
        describe("accumulation label") {
            
            context("regular", {
                it("should be") {
                    expect(inchAccu.label).to(equal("0.4 in"))
                }
            })
            
            context("centimeters", {
                it("should be") {
                    expect(inchAccu.label(as: .centimeter)).to(equal("1 cm"))
                }
            })
            
        }
        
        SwiftSky.units.accumulation = .centimeter
        let centiAccu = Accumulation(10.16, withUnit: .centimeter)
        describe("accumulation convert") {
            
            context("millimeters", {
                it("should be") {
                    expect(centiAccu.value(as: .centimeter)).to(equal(10.16))
                }
            })
            
            context("inches", {
                it("should be") {
                    expect(centiAccu.value(as: .inch)).to(equal(4))
                }
            })
            
        }
        
        describe("precipitation object") {
            
            context("no data", {
                it("should be") {
                    let object = Precipitation(type: .none, accumulation: nil, intensity: nil, maxIntensity: nil, maxIntensityTime: nil, probability: nil)
                    expect(object.hasData).to(equal(false))
                }
            })
            
            context("type", {
                it("should be") {
                    let object = Precipitation(type: .rain, accumulation: inchAccu, intensity: nil, maxIntensity: nil, maxIntensityTime: nil, probability: nil)
                    expect(object.hasData).to(equal(true))
                }
            })

            
            context("accumulation", {
                it("should be") {
                    let object = Precipitation(type: .none, accumulation: inchAccu, intensity: nil, maxIntensity: nil, maxIntensityTime: nil, probability: nil)
                    expect(object.hasData).to(equal(true))
                }
            })
            
            context("intensity", {
                it("should be") {
                    let object = Precipitation(type: .none, accumulation: nil, intensity: inches, maxIntensity: nil, maxIntensityTime: nil, probability: nil)
                    expect(object.hasData).to(equal(true))
                }
            })
            
            context("max intensity", {
                it("should be") {
                    let object = Precipitation(type: .none, accumulation: nil, intensity: nil, maxIntensity: inches, maxIntensityTime: nil, probability: nil)
                    expect(object.hasData).to(equal(true))
                }
            })
            
            context("max intensity time", {
                it("should be") {
                    let object = Precipitation(type: .none, accumulation: nil, intensity: nil, maxIntensity: nil, maxIntensityTime: Date(), probability: nil)
                    expect(object.hasData).to(equal(true))
                }
            })
            
            context("probability", {
                it("should be") {
                    let object = Precipitation(type: .none, accumulation: nil, intensity: nil, maxIntensity: nil, maxIntensityTime: nil, probability: Percentage(0.5))
                    expect(object.hasData).to(equal(true))
                }
            })
            
        }
        
    }

}

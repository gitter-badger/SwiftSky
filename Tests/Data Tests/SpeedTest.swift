//
//  SpeedTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftSky

class SpeedTest : QuickSpec {
    
    override func tearDown() {
        SwiftSky.units = UnitProfile()
        SwiftSky.locale = Locale.current
        super.tearDown()
    }
    
    override func setUp() {
        SwiftSky.locale = Locale(identifier: "en-US")
    }
    
    override func spec() {
        
        let mph = Speed(1, withUnit: .milePerHour)
        describe("labels") {
            it("mph label should be") {
                expect(mph.label).to(equal("1 mph"))
            }
            it("kph label should be") {
                expect(mph.label(as: .kilometerPerHour)).to(equal("2 kph"))
            }
            it("m/s label should be") {
                expect(mph.label(as: .meterPerSecond)).to(equal("0.4 m/s"))
            }
        }
        
        describe("conversions") {
            SwiftSky.units.speed = .kilometerPerHour
            let kph = Speed(10, withUnit: .kilometerPerHour)
            context("kph to", {
                it("kph should be") {
                    expect(kph.value(as: .kilometerPerHour)).to(equal(10))
                }
                it("mph should be") {
                    expect(kph.value(as: .milePerHour)).to(equal(10 / 1.609344))
                }
                it("m/s should be") {
                    expect(kph.value(as: .meterPerSecond)).to(equal(10 / 3.6))
                }
            })
            SwiftSky.units.speed = .meterPerSecond
            let ms = Speed(1, withUnit: .meterPerSecond)
            context("m/s to", {
                it("m/s should be") {
                    expect(ms.value(as: .meterPerSecond)).to(equal(1))
                }
                it("mph should be") {
                    expect(ms.value(as: .milePerHour)).to(equal(1 / 0.44704))
                }
                it("kph should be") {
                    expect(ms.value(as: .kilometerPerHour)).to(equal(3.6))
                }
            })
        }
        
    }
    
}

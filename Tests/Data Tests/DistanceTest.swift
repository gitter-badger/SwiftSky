//
//  DistanceTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftSky

class DistanceTest : QuickSpec {

    override func tearDown() {
        SwiftSky.units = UnitProfile()
        SwiftSky.locale = Locale.current
        super.tearDown()
    }
    
    override func setUp() {
        SwiftSky.locale = Locale(identifier: "en-US")
    }
    
    override func spec() {
        
        let miles = Distance(1, withUnit: .mile)
        describe("labels") {
            it("mile label should be") {
                expect(miles.label).to(equal("1 mi"))
            }
            it("yard label should be") {
                expect(miles.label(as: .yard)).to(equal("1760 yd"))
            }
            it("kilometer label should be") {
                expect(miles.label(as: .kilometer)).to(equal("1.6 km"))
            }
            it("meter label should be") {
                expect(miles.label(as: .meter)).to(equal("1609 m"))
            }
        }
        
        describe("conversions") {
            SwiftSky.units.distance = .yard
            let yard = Distance(1760, withUnit: .yard)
            context("yard to", { 
                it("yard should be") {
                    expect(yard.value(as: .yard)).to(equal(1760))
                }
                it("mile should be") {
                    expect(yard.value(as: .mile)).to(equal(1))
                }
                it("kilometer should be") {
                    expect(yard.value(as: .kilometer)).to(equal(1760 * 0.0009144))
                }
                it("meter should be") {
                    expect(yard.value(as: .meter)).to(equal(1760 * 0.9144))
                }
            })
            SwiftSky.units.distance = .kilometer
            let kilometer = Distance(1, withUnit: .kilometer)
            context("kilometer to", {
                it("kilometer should be") {
                    expect(kilometer.value(as: .kilometer)).to(equal(1))
                }
                it("mile should be") {
                    expect(kilometer.value(as: .mile)).to(equal(1 / 1.609344))
                }
                it("yard should be") {
                    expect(kilometer.value(as: .yard)).to(equal(1 / 0.0009144))
                }
                it("meter should be") {
                    expect(kilometer.value(as: .meter)).to(equal(1000))
                }
            })
            SwiftSky.units.distance = .meter
            let meter = Distance(1000, withUnit: .meter)
            context("meter to", {
                it("meter should be") {
                    expect(meter.value(as: .meter)).to(equal(1000))
                }
                it("mile should be") {
                    expect(meter.value(as: .mile)).to(equal(1000 / 1609.344))
                }
                it("yard should be") {
                    expect(meter.value(as: .yard)).to(equal(1000 / 0.9144))
                }
                it("kilometer should be") {
                    expect(meter.value(as: .kilometer)).to(equal(1))
                }
            })
        }
        
    }
    
}

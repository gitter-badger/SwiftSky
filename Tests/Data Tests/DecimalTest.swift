//
//  DecimalTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftSky

class DecimalTest : QuickSpec {
    
    override func tearDown() {
        SwiftSky.locale = Locale.current
        super.tearDown()
    }
    
    override func setUp() {
        SwiftSky.locale = Locale(identifier: "en-US")
    }
    
    override func spec() {
        
        let number : Float = 0.2935784
        
        describe("no decimals") {
            it("should be") { 
                expect(number.noDecimal).to(equal("0"))
            }
        }
        
        describe("one decimals") {
            it("should be") {
                expect(number.oneDecimal).to(equal("0.3"))
            }
        }
        
        describe("two decimals") {
            it("should be") {
                expect(number.twoDecimal).to(equal("0.29"))
            }
        }
        
    }
    
}

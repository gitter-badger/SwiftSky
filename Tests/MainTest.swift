//
//  MainTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
import CoreLocation
import Alamofire
@testable import SwiftSky

class EmptyForecastTest : QuickSpec {
    
    override func spec() {
        describe("no header request") {
            it("should be", closure: { 
                let forecast = Forecast(nil, headers: nil)
                expect(forecast.alerts).to(beNil())
                expect(forecast.current).to(beNil())
                expect(forecast.days).to(beNil())
                expect(forecast.hours).to(beNil())
                expect(forecast.minutes).to(beNil())
                expect(forecast.timezone).to(beNil())
                expect(forecast.location).to(beNil())
                expect(forecast.metadata).to(beNil())
            })
        }
    }
    
}

class EmptyLocationTest : QuickSpec {
    
    let latitude = 47.20296790272209
    let longitude = -123.41670367098749
    
    override func spec() {
        describe("empty location") {
            it("should be", closure: {
                SwiftSky.key = "fake_key"
                var success = true
                waitUntil { done in
                    SwiftSky.get([.current], at: "") { result in
                        switch result {
                        case .success:
                            success = true
                        case .failure:
                            success = false
                        }
                        done()
                    }
                }
                expect(success).to(equal(false))
            })
        }
    }
    
}

class NoSecretTest : QuickSpec {
    
    let latitude = 47.20296790272209
    let longitude = -123.41670367098749
    
    override func spec() {
        describe("empty location") {
            it("should be", closure: {
                var success = true
                waitUntil { done in
                    SwiftSky.get([.current], at: "0,0") { result in
                        switch result {
                        case .success:
                            success = true
                        case .failure:
                            success = false
                        }
                        done()
                    }
                }
                expect(success).to(equal(false))
            })
        }
    }
    
}

class NoDataRequest : QuickSpec {
    
    let latitude = 47.20296790272209
    let longitude = -123.41670367098749
    
    override func spec() {
        describe("empty location") {
            it("should be", closure: {
                SwiftSky.key = "fake_key"
                var success = true
                waitUntil { done in
                    SwiftSky.get([], at: "0,0") { result in
                        switch result {
                        case .success:
                            success = true
                        case .failure:
                            success = false
                        }
                        done()
                    }
                }
                expect(success).to(equal(false))
            })
        }
    }
    
}

class NonGetTest : QuickSpec {
    
    let latitude = 47.20296790272209
    let longitude = -123.41670367098749
    
    override func spec() {
        describe("failing get") {
            it("should be", closure: {
                
                SwiftSky.key = "fake_key"
                var success = true
                waitUntil { done in
                    let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
                    SwiftSky.get([.current], at: location) { result in
                        switch result {
                        case .success:
                            success = true
                        case .failure:
                            success = false
                        }
                        done()
                    }
                }
                expect(success).to(equal(false))
                
            })
        }
    }
    
}

class ServerErrorGet : QuickSpec {
    
    let latitude = 47.20296790272209
    let longitude = -123.41670367098749
    
    override func tearDown() {
        SwiftSky.key = nil
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    override func setUp() {
        _ = stub(condition: isHost("api.darksky.net")) { _ in
            return fixture(
                filePath: OHPathForFile("forecast_fail.json", type(of: self))!,
                status: 500,
                headers: ["Content-Type":"application/json", "X-Forecast-API-Calls":"1", "X-Response-Time":"0.5"]
            )
        }
        super.setUp()
    }
    
    override func spec() {
        describe("getting forecast") {
            context("regular", {
                it("should load", closure: {
                    SwiftSky.key = "fake_key"
                    var success = false
                    waitUntil { done in
                        let location = Location(latitude: self.latitude, longitude: self.longitude).asLocation()!
                        SwiftSky.get([.current], at: location) { result in
                            switch result {
                            case .success:
                                success = true
                            case .failure:
                                success = false
                            }
                            done()
                        }
                    }
                    expect(success).to(equal(false))
                })
            })
        }
    }
}

class NoInternetTest : QuickSpec {
    
    let latitude = 47.20296790272209
    let longitude = -123.41670367098749
    
    override func tearDown() {
        SwiftSky.key = nil
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    override func setUp() {
        _ = stub(condition: isHost("api.darksky.net")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        super.setUp()
    }
    
    override func spec() {
        describe("getting forecast") {
            context("regular", {
                it("should load", closure: {
                    SwiftSky.key = "fake_key"
                    var success = false
                    var response : Forecast? = nil
                    var error : ApiError? = nil
                    waitUntil { done in
                        let location = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
                        SwiftSky.get([.current], at: location) { result in
                            switch result {
                            case .success:
                                success = true
                            case .failure:
                                success = false
                            }
                            response = result.response
                            error = result.error
                            done()
                        }
                    }
                    expect(success).to(equal(false))
                    expect(error).notTo(beNil())
                    expect(response).to(beNil())
                })
            })
        }
    }
}

class RegularGetTest : QuickSpec {
    
    let latitude = 47.20296790272209
    let longitude = -123.41670367098749
    
    override func tearDown() {
        SwiftSky.key = nil
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    override func setUp() {
        _ = stub(condition: isHost("api.darksky.net")) { _ in
            return fixture(
                filePath: OHPathForFile("forecast.json", type(of: self))!,
                headers: ["Content-Type":"application/json", "X-Forecast-API-Calls":"1", "X-Response-Time":"0.5"]
            )
        }
        super.setUp()
    }
    
    override func spec() {
        describe("getting forecast") {
            context("regular", { 
                it("should load", closure: {
                    SwiftSky.key = "fake_key"
                    var response : Forecast? = nil
                    var error : ApiError? = nil
                    waitUntil { done in
                        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
                        SwiftSky.get([.current], at: location) { result in
                            response = result.response
                            error = result.error
                            done()
                        }
                    }
                    expect(response).notTo(beNil())
                    expect(error).to(beNil())
                })
            })
        }
    }

}

class NoHeaderGetTest : QuickSpec {
    
    let latitude = 47.20296790272209
    let longitude = -123.41670367098749
    
    override func tearDown() {
        SwiftSky.key = nil
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    override func setUp() {
        _ = stub(condition: isHost("api.darksky.net")) { _ in
            return fixture(
                filePath: OHPathForFile("forecast.json", type(of: self))!,
                headers: ["Content-Type":"application/json"]
            )
        }
        super.setUp()
    }
    
    override func spec() {
        describe("getting forecast") {
            context("no header", {
                it("should load", closure: {
                    SwiftSky.key = "fake_key"
                    var success = false
                    waitUntil { done in
                        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
                        SwiftSky.get([.current], at: location) { result in
                            switch result {
                            case .success:
                                success = true
                            case .failure:
                                success = false
                            }
                            done()
                        }
                    }
                    expect(success).to(equal(true))
                })
            })
        }
    }
    
}

class BareMinimumGetTest : QuickSpec {
    
    let latitude = 47.20296790272209
    let longitude = -123.41670367098749
    
    override func tearDown() {
        SwiftSky.key = nil
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    override func setUp() {
        _ = stub(condition: isHost("api.darksky.net")) { _ in
            return fixture(
                filePath: OHPathForFile("forecast_bare.json", type(of: self))!,
                headers: ["Content-Type":"application/json", "X-Forecast-API-Calls":"1", "X-Response-Time":"0.5"]
            )
        }
        super.setUp()
    }
    
    override func spec() {
        describe("getting forecast") {
            context("bare minimum", {
                it("should load", closure: {
                    SwiftSky.key = "fake_key"
                    var success = false
                    waitUntil { done in
                        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
                        SwiftSky.get([.current], at: location) { result in
                            switch result {
                            case .success:
                                success = true
                            case .failure:
                                success = false
                            }
                            done()
                        }
                    }
                    expect(success).to(equal(true))
                })
            })
        }
    }
    
}

class NoApiKeyGetTest : QuickSpec {
    
    let latitude = 47.20296790272209
    let longitude = -123.41670367098749
    
    override func tearDown() {
        SwiftSky.key = nil
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    override func setUp() {
        _ = stub(condition: isHost("api.darksky.net")) { _ in
            return fixture(
                filePath: OHPathForFile("forecast.json", type(of: self))!,
                headers: ["Content-Type":"application/json","X-Forecast-API-Calls":"1","X-Response-Time":"0.5"]
            )
        }
        super.setUp()
    }
    
    override func spec() {
        describe("getting forecast") {
            context("no api key", {
                it("should load", closure: {
                    var response : Forecast? = nil
                    var error : ApiError? = nil
                    waitUntil { done in
                        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
                        SwiftSky.get([.current], at: location) { result in
                            response = result.response
                            error = result.error
                            done()
                        }
                    }
                    expect(response).toNot(beNil())
                    expect(error).to(beNil())
                })
            })
        }
    }
    
}

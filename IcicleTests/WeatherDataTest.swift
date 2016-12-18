//
//  WeatherDataTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/15/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
import Argo
import CoreLocation
@testable import Icicle

class WeatherDataTest: XCTestCase {
    func setupWeather(jsonFile:String, location:Location = Location(coordinates: CLLocation(latitude:0, longitude:0), name: "Default City")) -> WeatherData {
        let data = getTestJSON(named: jsonFile, forClass: type(of:self))
        let models = decoder(data:data).successValue()!
        let wd = WeatherData.create(models: models, location: location)
        return wd.successValue()!
    }

    func testSunnySummary() {
        let wd = setupWeather(jsonFile: "sunny-hot")
        XCTAssertEqual(wd.fullSummary, "Currently 83°, but feels like 81°. Clear for the hour. Dry throughout the day. Tomorrow, dry throughout the day, high of 97°. No precipitation throughout the week, with temperatures falling to 67°F on Sunday.")
    }
    
    func testRainySummary() {
        let wd = setupWeather(jsonFile: "cloudy-futurerain")
        XCTAssertEqual(wd.fullSummary, "Currently 61°. Partly cloudy for the hour. Partly cloudy until this evening. Tomorrow, mostly cloudy starting in the evening, high of 61°. Light rain on Tuesday through Sunday, with temperatures peaking at 66°F on Tuesday.")
    }
    
    func testLocationName() {
        let location = Location(coordinates: CLLocation(latitude:0, longitude:0), name: "Concord")
        let wd = setupWeather(jsonFile: "sunny-hot", location: location)
        XCTAssertEqual(wd.locationName, "Concord")
    }
    
    func testSunnyColor() {
        let wd = setupWeather(jsonFile: "sunny-hot")
        XCTAssertEqual(wd.weatherColor, IcicleColor.orange)
    }
    
    func testPartlyCloudyColor() {
        let wd = setupWeather(jsonFile: "cloudy-futurerain")
        XCTAssertEqual(wd.weatherColor, IcicleColor.green)
    }
    
    func testHours() {
        let wd = setupWeather(jsonFile: "cloudy-futurerain")
        let hour = wd.hours[44]
        XCTAssertEqual(hour.summary, "Rain")
    }
}

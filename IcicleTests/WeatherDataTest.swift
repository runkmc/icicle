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
        let currentlyJson = parseJSON(data: data, granularity: .current)
        let minutesJson = parseJSON(data: data, granularity: .minute)
        let hoursJson = parseJSON(data: data, granularity: .hour)
        let daysJson = parseJSON(data: data, granularity: .day)
        
        let currently: Decoded<Currently> = decode(currentlyJson.successValue()!)
        let minutes: Decoded<Minutes> = decode(minutesJson.successValue()!)
        let hours: Decoded<Hours> = decode(hoursJson.successValue()!)
        let days: Decoded<Days> = decode(daysJson.successValue()!)
        let models = WeatherModels(currently: currently.value!, minutes: minutes.value!, hours: hours.value!, days: days.value!)
        
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
}

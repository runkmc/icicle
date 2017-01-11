//
//  HourDataTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 12/3/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
import Argo
import CoreLocation
@testable import Icicle

class HourDataTest: XCTestCase {
    func setupWeather(jsonFile:String) -> WeatherData {
        let data = getTestJSON(named: jsonFile, forClass: type(of:self))
        let models = decoder(data:data).successValue()!
        let location = Location(coordinates: CLLocation(latitude:0, longitude:0), name: "Default City")
        let wd = WeatherData.create(models: models, location: location)
        return wd.successValue()!
    }

    func testSunnyCreation() {
        let wd = setupWeather(jsonFile: "sunny-hot")
        let hour = wd.hours[0]
        
        XCTAssertEqual("12 PM", hour.time)
        XCTAssertEqual("Clear", hour.summary)
        XCTAssertEqual("82°", hour.temperature)
        XCTAssertEqual("0%", hour.precipChance)
        XCTAssertEqual("—", hour.precipType)
        XCTAssertEqual("81°", hour.apparentTemperature)
        XCTAssertEqual("32%", hour.humidity)
    }
    
    func testRainyCreation() {
        let wd = setupWeather(jsonFile: "cloudy-futurerain")
        let hour = wd.hours[44]

        XCTAssertEqual("11 AM", hour.time)
        XCTAssertEqual("Rain", hour.summary)
        XCTAssertEqual("61°", hour.temperature)
        XCTAssertEqual("61%", hour.precipChance)
        XCTAssertEqual("Rain", hour.precipType)
        XCTAssertEqual("61°", hour.apparentTemperature)
        XCTAssertEqual("95%", hour.humidity)
    }

}

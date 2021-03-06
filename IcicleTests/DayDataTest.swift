//
//  DayDataTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 11/20/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import Icicle

class DayDataTest: XCTestCase {
    func setupWeather(jsonFile:String) -> WeatherData {
        let data = getTestJSON(named: jsonFile, forClass: type(of:self))
        let models = decoder(data:data).successValue()!
        let location = Location(coordinates: CLLocation(latitude:0, longitude:0), name: "Default City")
        let wd = WeatherData.create(models: models, location:location)
        return wd.successValue()!
    }
    
    func testSunnyCreation() {
        let wd = setupWeather(jsonFile: "sunny-hot")
        let day = wd.days[0]

        XCTAssertEqual("9/25", day.date)
        XCTAssertEqual("94° at 4 PM", day.high)
        XCTAssertEqual("56° at 6 AM", day.low)
        XCTAssertEqual("Dry throughout the day.", day.summary)
    }
    
    func testRainyCreation() {
        let wd = setupWeather(jsonFile: "cloudy-futurerain")
        let day = wd.days[4]
        
        XCTAssertEqual("9/29", day.date)
        XCTAssertEqual("65° at 4 PM", day.high)
        XCTAssertEqual("56° at 11 PM", day.low)
        XCTAssertEqual("Light rain and breezy throughout the day.", day.summary)
    }
}
